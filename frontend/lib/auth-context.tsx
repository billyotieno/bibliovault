'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { authApi } from './api';

interface User {
  id: number;
  username: string;
  email: string;
  firstName: string | null;
  lastName: string | null;
  role: string;
}

interface AuthContextType {
  user: User | null;
  token: string | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  register: (userData: { username: string; email: string; password: string; firstName?: string; lastName?: string }) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Check for stored token on mount
    const storedToken = localStorage.getItem('bibliovault_token');
    const storedUser = localStorage.getItem('bibliovault_user');
    
    if (storedToken && storedUser) {
      setToken(storedToken);
      setUser(JSON.parse(storedUser));
      
      // Verify token is still valid
      authApi.getMe(storedToken).catch(() => {
        // Token invalid, clear storage
        localStorage.removeItem('bibliovault_token');
        localStorage.removeItem('bibliovault_user');
        setToken(null);
        setUser(null);
      });
    }
    
    setIsLoading(false);
  }, []);

  const login = async (email: string, password: string) => {
    const response = await authApi.login({ email, password });
    
    if (response.success) {
      const { user, token } = response.data;
      setUser(user);
      setToken(token);
      localStorage.setItem('bibliovault_token', token);
      localStorage.setItem('bibliovault_user', JSON.stringify(user));
    } else {
      throw new Error(response.message);
    }
  };

  const register = async (userData: { username: string; email: string; password: string; firstName?: string; lastName?: string }) => {
    const response = await authApi.register(userData);
    
    if (response.success) {
      const { user, token } = response.data;
      setUser(user);
      setToken(token);
      localStorage.setItem('bibliovault_token', token);
      localStorage.setItem('bibliovault_user', JSON.stringify(user));
    } else {
      throw new Error(response.message);
    }
  };

  const logout = () => {
    setUser(null);
    setToken(null);
    localStorage.removeItem('bibliovault_token');
    localStorage.removeItem('bibliovault_user');
  };

  return (
    <AuthContext.Provider value={{
      user,
      token,
      isLoading,
      isAuthenticated: !!user,
      login,
      register,
      logout
    }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}

export function ProtectedRoute({ children }: { children: ReactNode }) {
  const { isAuthenticated, isLoading } = useAuth();
  
  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
      </div>
    );
  }
  
  if (!isAuthenticated) {
    // Redirect to login - in a real app you'd use Next.js router
    if (typeof window !== 'undefined') {
      window.location.href = '/login';
    }
    return null;
  }
  
  return <>{children}</>;
}
