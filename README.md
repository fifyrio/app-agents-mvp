# My App - Full Stack Flutter & Cloudflare Workers

A full-stack application with Flutter frontend and Cloudflare Workers backend.

## Project Structure

```
my-app/
├── frontend/                # Flutter application
│   ├── lib/
│   ├── pubspec.yaml
│   └── test/
│
├── backend/                 # Cloudflare Workers API
│   ├── src/
│   ├── api/
│   ├── models/
│   ├── utils/
│   ├── test/
│   └── package.json
│
└── .claude/
    └── agents/             # Claude Code agent configurations
        ├── flutter-ui-expert.md
        ├── getx-state-manager.md
        ├── backend-architect.md
        └── api-tester.md
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Node.js (18+)
- npm or yarn
- Cloudflare account (for backend deployment)

### Frontend Setup

```bash
cd frontend
flutter pub get
flutter run
```

For more details, see [frontend/README.md](frontend/README.md)

### Backend Setup

```bash
cd backend
npm install
npm run dev
```

For more details, see [backend/README.md](backend/README.md)

## Development Workflow

### Running Both Services

1. Terminal 1 - Backend:
```bash
cd backend
npm run dev
```

2. Terminal 2 - Frontend:
```bash
cd frontend
flutter run
```

### Testing

Backend tests:
```bash
cd backend
npm test
```

Frontend tests:
```bash
cd frontend
flutter test
```

## Claude Code Agents

This project includes specialized agents for different aspects of development:

- **flutter-ui-expert**: UI/UX implementation and widget design
- **getx-state-manager**: State management with GetX
- **backend-architect**: API design and backend architecture
- **api-tester**: API testing and quality assurance

## Deployment

### Frontend (Flutter)
- Web: `flutter build web`
- iOS: `flutter build ios`
- Android: `flutter build apk`

### Backend (Cloudflare Workers)
```bash
cd backend
npx wrangler login
npm run deploy
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests
4. Submit a pull request

## License

MIT
