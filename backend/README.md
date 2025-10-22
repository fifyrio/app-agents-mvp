# Backend - Cloudflare Workers

This is the backend service for my-app, built with Cloudflare Workers and Hono framework.

## Getting Started

### Prerequisites
- Node.js 18+
- npm or yarn
- Cloudflare account (for deployment)

### Installation

```bash
npm install
```

### Development

Run the development server:

```bash
npm run dev
```

The API will be available at `http://localhost:8787`

### Testing

```bash
npm test
```

### Deployment

```bash
# Login to Cloudflare
npx wrangler login

# Deploy to production
npm run deploy
```

## Project Structure

```
backend/
├── src/
│   └── index.js          # Main entry point
├── api/                  # API route handlers
├── models/              # Data models
├── utils/               # Utility functions
├── test/                # Test files
├── package.json
└── wrangler.toml        # Cloudflare Workers config
```

## API Endpoints

- `GET /` - Health check
- `GET /api/health` - API health status
- `GET /api/hello?name=<name>` - Example endpoint
