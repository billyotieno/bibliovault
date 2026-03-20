import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import dotenv from 'dotenv';
import authRoutes from './routes/auth';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3001',
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    message: 'BiblioVault API is running',
    timestamp: new Date().toISOString()
  });
});

// Auth routes
app.use('/api/auth', authRoutes);

// Start server
app.listen(PORT, () => {
  console.log(`🚀 BiblioVault backend running on http://localhost:${PORT}`);
  console.log(`📚 Environment: ${process.env.NODE_ENV || 'development'}`);
});

export default app;
