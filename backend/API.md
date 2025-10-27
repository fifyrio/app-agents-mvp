# ColorWise Backend API Documentation

**版本**: v1.0.0
**更新日期**: 2025-10-27

---

## 📚 目录

- [概述](#概述)
- [基础信息](#基础信息)
- [系统端点](#系统端点)
- [业务端点](#业务端点)
  - [衣橱管理](#衣橱管理)
- [错误处理](#错误处理)
- [开发指南](#开发指南)

---

## 概述

ColorWise API 是一个基于 Cloudflare Workers 的 RESTful API，使用 Hono 框架构建。提供色彩分析、衣橱推荐、用户管理等功能。

### 技术栈

- **Runtime**: Cloudflare Workers
- **Framework**: Hono v4.6+
- **Language**: JavaScript (ES Modules)

---

## 基础信息

### Base URL

- **开发环境**: `http://localhost:8787`
- **生产环境**: `https://api.colorwise.app` (待配置)

### 通用响应格式

#### 成功响应

```json
{
  "success": true,
  "data": {},
  "message": "Success"
}
```

#### 错误响应

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Error description"
  }
}
```

### 请求头

所有请求应包含：

```
Content-Type: application/json
Accept: application/json
```

认证请求还需包含：

```
Authorization: Bearer <token>
```

### CORS

所有端点已启用 CORS，支持跨域请求。

---

## 系统端点

### GET /

根路径健康检查。

**认证**: ❌ 不需要

**请求示例**:
```bash
curl http://localhost:8787/
```

**响应**:
```json
{
  "message": "Welcome to my-app backend API",
  "status": "healthy",
  "timestamp": "2025-10-27T10:30:00.000Z"
}
```

---

### GET /api/health

健康检查端点。

**认证**: ❌ 不需要

**请求示例**:
```bash
curl http://localhost:8787/api/health
```

**响应**:
```json
{
  "status": "ok"
}
```

---

### GET /api/hello

示例端点，用于测试。

**认证**: ❌ 不需要

**Query 参数**:
| 参数 | 类型 | 必填 | 说明 | 默认值 |
|------|------|------|------|--------|
| `name` | string | ❌ | 问候的名字 | "World" |

**请求示例**:
```bash
# 默认
curl http://localhost:8787/api/hello

# 带参数
curl "http://localhost:8787/api/hello?name=Alice"
```

**响应**:
```json
{
  "message": "Hello, Alice!"
}
```

---

## 业务端点

### 衣橱管理

#### GET /wardrobe

获取衣橱场景推荐和过滤器列表。

**认证**: ❌ 不需要

**请求示例**:
```bash
curl http://localhost:8787/wardrobe
```

**响应结构**:
```json
{
  "filters": [
    {
      "id": "string",        // 过滤器 ID
      "title": "string",     // 显示名称
      "selected": boolean    // 是否默认选中
    }
  ],
  "scenes": [
    {
      "id": "string",           // 场景唯一 ID
      "title": "string",        // 场景标题
      "subtitle": "string",     // 副标题/描述
      "palette": ["#HEX"],      // 颜色调色板
      "image_url": "string",    // 图片 URL
      "tags": ["string"],       // 标签（如 "premium"）
      "category": "string",     // 分类
      "is_premium": boolean     // 是否需要订阅
    }
  ]
}
```

**响应示例**:
```json
{
  "filters": [
    { "id": "all", "title": "All", "selected": true },
    { "id": "work", "title": "Work", "selected": false },
    { "id": "date", "title": "Date", "selected": false },
    { "id": "travel", "title": "Travel", "selected": false },
    { "id": "party", "title": "Party", "selected": false },
    { "id": "interview", "title": "Interview", "selected": false }
  ],
  "scenes": [
    {
      "id": "chic_city_brunch",
      "title": "Chic City Brunch",
      "subtitle": "Cool summer palette",
      "palette": ["#2B3A42", "#E4E8EB", "#F9C9C8"],
      "image_url": "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400",
      "tags": ["premium"],
      "category": "date",
      "is_premium": true
    },
    {
      "id": "boardroom_ready",
      "title": "Boardroom Ready",
      "subtitle": "Deep winter power look",
      "palette": ["#1C1C1E", "#E04E39", "#A9B0B7"],
      "image_url": "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400",
      "tags": [],
      "category": "work",
      "is_premium": false
    }
  ]
}
```

**字段说明**:

##### Filters
- `id`: 过滤器唯一标识符
- `title`: UI 显示名称
- `selected`: 是否默认选中

##### Scenes
- `id`: 场景唯一标识符 (snake_case)
- `title`: 场景主标题
- `subtitle`: 场景副标题/描述
- `palette`: 颜色调色板数组（十六进制格式）
- `image_url`: 场景预览图 URL
- `tags`: 标签数组，可包含 "premium" 等
- `category`: 场景分类 (work/date/travel/party/interview)
- `is_premium`: 是否需要高级订阅

**支持的分类**:
- `work` - 工作场合
- `date` - 约会场合
- `travel` - 旅行场合
- `party` - 派对场合
- `interview` - 面试场合

**使用示例 (JavaScript)**:
```javascript
// Fetch wardrobe data
const response = await fetch('http://localhost:8787/wardrobe');
const data = await response.json();

console.log('Filters:', data.filters);
console.log('Scenes:', data.scenes);

// 过滤特定分类
const workScenes = data.scenes.filter(scene => scene.category === 'work');
console.log('Work scenes:', workScenes);

// 仅显示 Premium 场景
const premiumScenes = data.scenes.filter(scene => scene.is_premium);
console.log('Premium scenes:', premiumScenes);
```

**使用示例 (Dart/Flutter)**:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchWardrobe() async {
  final response = await http.get(
    Uri.parse('http://localhost:8787/wardrobe'),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load wardrobe');
  }
}

// 使用
final data = await fetchWardrobe();
final scenes = data['scenes'] as List;
final filters = data['filters'] as List;
```

**注意事项**:
- 所有场景图片使用 Unsplash 作为图片源
- Premium 场景需要在客户端显示特殊标识
- 颜色调色板数组长度可变（通常 3-4 个颜色）
- 接口已启用 CORS，可从任何域名访问

---

## 错误处理

### HTTP 状态码

| 状态码 | 说明 |
|--------|------|
| 200 | 请求成功 |
| 201 | 资源创建成功 |
| 400 | 请求参数错误 |
| 401 | 未认证 |
| 403 | 权限不足 |
| 404 | 资源未找到 |
| 429 | 请求频率超限 |
| 500 | 服务器错误 |

### 错误代码

| 错误代码 | 说明 |
|----------|------|
| `INVALID_REQUEST` | 请求参数无效 |
| `UNAUTHORIZED` | 未授权访问 |
| `FORBIDDEN` | 禁止访问 |
| `NOT_FOUND` | 资源不存在 |
| `RATE_LIMIT_EXCEEDED` | 超出请求频率限制 |
| `INTERNAL_ERROR` | 内部服务器错误 |
| `SUBSCRIPTION_REQUIRED` | 需要订阅 Premium |

### 错误响应示例

```json
{
  "success": false,
  "error": {
    "code": "SUBSCRIPTION_REQUIRED",
    "message": "This feature requires a Premium subscription",
    "details": {
      "feature": "ai_outfit_generation",
      "required_plan": "premium"
    }
  }
}
```

---

## 开发指南

### 本地开发

```bash
# 克隆项目
git clone <repo-url>
cd backend

# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 运行测试
npm test

# 部署到 Cloudflare
npm run deploy
```

### 添加新端点

1. **在 `src/index.js` 中添加路由**:
```javascript
// Example: GET endpoint
app.get('/api/new-endpoint', (c) => {
  return c.json({
    success: true,
    data: { message: 'Hello!' }
  });
});

// Example: POST endpoint
app.post('/api/new-endpoint', async (c) => {
  const body = await c.req.json();
  return c.json({
    success: true,
    data: { received: body }
  });
});
```

2. **更新本文档**:
   - 在相应的业务端点部分添加新端点文档
   - 包含请求/响应示例
   - 说明字段含义和用法

3. **编写测试** (在 `test/` 目录):
```javascript
import { describe, it, expect } from 'vitest';
import app from '../src/index.js';

describe('New Endpoint', () => {
  it('should return expected response', async () => {
    const res = await app.request('/api/new-endpoint');
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.success).toBe(true);
  });
});
```

### 环境变量

在 `wrangler.toml` 中配置环境变量：

```toml
[vars]
API_KEY = "your-api-key"
ENVIRONMENT = "development"
```

### 部署

```bash
# 部署到生产环境
npm run deploy

# 查看日志
wrangler tail
```

---

## 变更日志

### v1.0.0 (2025-10-27)
- ✅ 初始版本发布
- ✅ 添加 `/wardrobe` 端点
- ✅ 添加健康检查端点
- ✅ 启用 CORS 支持

---

## 规划中的功能

以下端点正在规划中，即将推出：

### 🎨 色彩分析
- `POST /api/color-analysis` - 上传照片进行色彩分析
- `GET /api/color-analysis/:id` - 获取分析结果
- `GET /api/color-analysis/history` - 获取历史记录

### 👤 用户管理
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `GET /api/user/profile` - 获取用户资料
- `PUT /api/user/profile` - 更新用户资料

### 💎 订阅管理
- `GET /api/subscription/plans` - 获取订阅计划
- `POST /api/subscription/subscribe` - 创建订阅
- `GET /api/subscription/status` - 查询订阅状态

### 🖼️ AI 图片生成
- `POST /api/generate/outfit` - 生成服装搭配图
- `GET /api/generate/status/:id` - 查询生成状态

---

## 联系方式

- **GitHub**: [项目地址]
- **Email**: support@colorwise.app

## 许可证

MIT License

---

**© 2025 ColorWise. All rights reserved.**
