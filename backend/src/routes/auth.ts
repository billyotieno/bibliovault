import { Router } from 'express';
import { register, login, getMe, logout } from '../controllers/authController';
import { authenticate } from '../middleware/auth';

const router = Router();

// POST /api/auth/register
router.post('/register', register);

// POST /api/auth/login
router.post('/login', login);

// GET /api/auth/me - Get current user (protected)
router.get('/me', authenticate, getMe);

// POST /api/auth/logout
router.post('/logout', logout);

export default router;
