# Frontend - Flutter Application

A Flutter application with GetX state management, powered by Claude Code agents for intelligent development assistance.

## Claude Code Agents

This project leverages specialized AI agents located in `../.claude/agents/` to assist with different aspects of development:

### Available Agents

- **flutter-ui-expert.md**: Specializes in UI/UX implementation, Material Design, custom widgets, responsive layouts, and animations. References design mockups in `assets/ui_designs/`.

- **getx-state-manager.md**: Expert in GetX state management, controllers, reactive programming, dependency injection, and navigation.

- **backend-architect.md**: Handles backend API design and Cloudflare Workers integration. Works on the serverless backend in `../backend/`.

- **api-tester.md**: Focuses on API testing, integration tests, and ensuring backend reliability.

These agents provide context-aware assistance and follow best practices specific to their domains. They work together to maintain code quality and architectural consistency across the full stack.

## Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / Xcode (for mobile development)
- Chrome (for web development)

### Installation

```bash
flutter pub get
```

### Development

Run on your preferred platform:

```bash
# Web
flutter run -d chrome

# iOS Simulator
flutter run -d ios

# Android Emulator
flutter run -d android

# Desktop
flutter run -d macos  # or windows/linux
```

### Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

### Build

```bash
# Web
flutter build web

# iOS
flutter build ios

# Android
flutter build apk
flutter build appbundle
```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── routes/               # App routes (GetX)
├── pages/                # Screen widgets
├── widgets/              # Reusable widgets
├── controllers/          # GetX controllers
├── models/               # Data models
├── services/             # API and other services
├── bindings/             # GetX bindings
├── utils/                # Utility functions
└── constants/            # App constants
```

## State Management

This project uses GetX for state management. Key concepts:

- **Controllers**: Business logic and state
- **Bindings**: Dependency injection
- **Reactive variables**: `.obs` for reactive state
- **GetX widgets**: `Obx()` and `GetBuilder()`

## Backend Integration

This frontend connects to a **Cloudflare Workers** serverless backend located in `../backend/`. The backend provides:

- RESTful API endpoints built with Hono framework
- Edge computing for low-latency responses
- Serverless architecture for scalability
- CORS-enabled for Flutter app integration

### API Configuration

Configure the backend API base URL in:
- Development: `lib/constants/api_constants.dart`
- Environment variables for production

The backend runs on:
- Local development: `http://localhost:8787`
- Production: Your Cloudflare Workers domain

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://pub.dev/packages/get)
- [Material Design Guidelines](https://material.io/design)
