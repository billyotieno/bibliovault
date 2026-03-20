const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api';

interface ApiOptions {
  method?: string;
  body?: any;
  token?: string | null;
}

export async function apiClient(endpoint: string, options: ApiOptions = {}) {
  const { method = 'GET', body, token } = options;
  
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
  };

  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const config: RequestInit = {
    method,
    headers,
  };

  if (body) {
    config.body = JSON.stringify(body);
  }

  const response = await fetch(`${API_URL}${endpoint}`, config);
  const data = await response.json();

  if (!response.ok) {
    throw new Error(data.message || 'Something went wrong');
  }

  return data;
}

// Auth API
export const authApi = {
  register: (userData: { username: string; email: string; password: string; firstName?: string; lastName?: string }) =>
    apiClient('/auth/register', { method: 'POST', body: userData }),
  
  login: (credentials: { email: string; password: string }) =>
    apiClient('/auth/login', { method: 'POST', body: credentials }),
  
  getMe: (token: string) =>
    apiClient('/auth/me', { token }),
  
  logout: () =>
    apiClient('/auth/logout', { method: 'POST' }),
};
