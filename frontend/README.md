# Frontend - Flutter Application

A Flutter application for my-app with GetX state management.

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

## API Integration

The app connects to the backend API. Configure the base URL in:
- Development: `lib/constants/api_constants.dart`
- Environment variables for production

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://pub.dev/packages/get)
- [Material Design Guidelines](https://material.io/design)
