import { Hono } from 'hono';
import { cors } from 'hono/cors';
import { handleWardrobeRequest } from './handlers/wardrobe.js';

const app = new Hono();

// Enable CORS for Flutter frontend
app.use('/*', cors());

// Health check endpoint
app.get('/', (c) => {
  return c.json({
    message: 'Welcome to my-app backend API',
    status: 'healthy',
    timestamp: new Date().toISOString()
  });
});

// API routes
app.get('/api/health', (c) => {
  return c.json({ status: 'ok' });
});

// Example API endpoint
app.get('/api/hello', (c) => {
  const name = c.req.query('name') || 'World';
  return c.json({ message: `Hello, ${name}!` });
});

// Wardrobe endpoint - Returns outfit recommendations and filters
// Supports optional category filtering via query parameter (?category=work)
app.get('/wardrobe', handleWardrobeRequest);

export default app;
