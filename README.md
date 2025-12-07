cloudflare-workers-backend-dev 重构'/wardrobe'接口

# My App - Full Stack Flutter & Cloudflare Workers
# 使用方法:
claude code登录后

* 执行 `getx-app-entry-reviewer 初始化项目的app的入口配置`
* 执行 `flutter-ui-expert  复刻[图片路径]里的UI`
* 执行 `flutter-logic-engineer 集成接口... 并数据加载后刷新UI`


- `flutter-ui-expert`: Focused on Flutter UI/UX implementation. Use it when crafting responsive layouts, optimizing widget trees for performance, adding animations, or ensuring accessibility and design consistency.
- `flutter-logic-engineer`: Specializes in GetX business logic. Ideal for implementing or refactoring services and controllers, composing Http/Auth/Error mixins, structuring API calls with proper logging and error handling, and managing reactive state or dependency injection patterns.
- `getx-app-entry-reviewer`: Designed to audit Flutter app entry points. Engage it to review main/app files, service initialization order, navigation setup (routes, bottom navigation, deep links), and reactive flows that coordinate onboarding or global state.

<<<<<<< HEAD
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

## How to use

正确使用 Agents 的方式：

方式 1：直接请求使用特定 agent
请使用 flutter-ui-expert agent 帮我创建一个登录页面

方式 2：让 Claude 自动选择 agent
当你的请求与某个 agent 的专业领域匹配时，Claude Code 会自动使用相应的
agent。

方式 3：在会话中明确指定
让 backend-architect agent 设计一个用户认证 API

## License

MIT
