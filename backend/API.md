# ColorWise Backend API Documentation

**版本**: v1.1.0
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

获取衣橱场景推荐和过滤器列表。支持通过查询参数按分类过滤场景。

**认证**: ❌ 不需要

**Query 参数**:
| 参数 | 类型 | 必填 | 说明 | 默认值 |
|------|------|------|------|--------|
| `category` | string | ❌ | 场景分类过滤器 | "all" |

**有效的 category 值**:
- `all` - 返回所有场景（默认）
- `work` - 工作场合
- `date` - 约会场合
- `travel` - 旅行场合
- `party` - 派对场合
- `interview` - 面试场合

**请求示例**:
```bash
# 获取所有场景
curl http://localhost:8787/wardrobe

# 获取工作场景
curl "http://localhost:8787/wardrobe?category=work"

# 获取约会场景
curl "http://localhost:8787/wardrobe?category=date"
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

**响应示例（默认 - 所有场景）**:
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
    // ... 返回所有 8 个场景
  ]
}
```

**响应示例（按分类过滤 - category=work）**:
```json
{
  "filters": [
    { "id": "all", "title": "All", "selected": false },
    { "id": "work", "title": "Work", "selected": true },  // 选中状态更新
    { "id": "date", "title": "Date", "selected": false },
    { "id": "travel", "title": "Travel", "selected": false },
    { "id": "party", "title": "Party", "selected": false },
    { "id": "interview", "title": "Interview", "selected": false }
  ],
  "scenes": [
    {
      "id": "boardroom_ready",
      "title": "Boardroom Ready",
      "subtitle": "Deep winter power look",
      "palette": ["#1C1C1E", "#E04E39", "#A9B0B7"],
      "image_url": "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400",
      "tags": [],
      "category": "work",
      "is_premium": false
    },
    {
      "id": "office_power_move",
      "title": "Office Power Move",
      "subtitle": "Bold confidence",
      "palette": ["#B22222", "#000000", "#FFFFFF"],
      "image_url": "https://images.unsplash.com/photo-1592328715880-e335f08cb905?w=400",
      "tags": [],
      "category": "work",
      "is_premium": false
    }
    // ... 仅返回 work 分类的场景
  ]
}
```

**错误响应（无效分类）**:
```json
{
  "error": "Invalid category. Valid categories are: all, work, date, travel, party, interview"
}
```
HTTP 状态码: `400 Bad Request`

**字段说明**:

##### Filters
- `id`: 过滤器唯一标识符
- `title`: UI 显示名称
- `selected`: 是否选中（根据 `category` 查询参数动态更新）

##### Scenes
- `id`: 场景唯一标识符 (snake_case)
- `title`: 场景主标题
- `subtitle`: 场景副标题/描述
- `palette`: 颜色调色板数组（十六进制格式）
- `image_url`: 场景预览图 URL
- `tags`: 标签数组，可包含 "premium" 等
- `category`: 场景分类 (work/date/travel/party/interview)
- `is_premium`: 是否需要高级订阅

**场景数量统计**:
- **总场景数**: 8 个
- `work`: 2 个场景
- `date`: 2 个场景
- `travel`: 2 个场景
- `party`: 1 个场景
- `interview`: 1 个场景

**过滤行为**:
- 使用 `category` 参数时，只返回匹配该分类的场景
- `filters` 数组中对应分类的 `selected` 字段会自动设置为 `true`
- 无效的 `category` 值将返回 400 错误

**使用示例 (JavaScript)**:
```javascript
// 获取所有场景
const allResponse = await fetch('http://localhost:8787/wardrobe');
const allData = await allResponse.json();
console.log('All scenes:', allData.scenes.length); // 8

// 使用服务器端过滤获取工作场景
const workResponse = await fetch('http://localhost:8787/wardrobe?category=work');
const workData = await workResponse.json();
console.log('Work scenes:', workData.scenes.length); // 2
console.log('Work filter selected:', workData.filters.find(f => f.id === 'work').selected); // true

// 获取约会场景
const dateResponse = await fetch('http://localhost:8787/wardrobe?category=date');
const dateData = await dateResponse.json();
console.log('Date scenes:', dateData.scenes); // 返回 2 个约会场景

// 错误处理
try {
  const response = await fetch('http://localhost:8787/wardrobe?category=invalid');
  if (!response.ok) {
    const error = await response.json();
    console.error('Error:', error.error); // "Invalid category. Valid categories are: ..."
  }
} catch (error) {
  console.error('Request failed:', error);
}

// 客户端过滤 Premium 场景
const premiumScenes = allData.scenes.filter(scene => scene.is_premium);
console.log('Premium scenes:', premiumScenes);
```

**使用示例 (Dart/Flutter)**:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

// 获取所有场景
Future<Map<String, dynamic>> fetchWardrobe({String? category}) async {
  String url = 'http://localhost:8787/wardrobe';
  if (category != null && category != 'all') {
    url += '?category=$category';
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else if (response.statusCode == 400) {
    final error = json.decode(response.body);
    throw Exception(error['error']);
  } else {
    throw Exception('Failed to load wardrobe');
  }
}

// 使用示例
// 获取所有场景
final allData = await fetchWardrobe();
print('Total scenes: ${allData['scenes'].length}'); // 8

// 获取工作场景
final workData = await fetchWardrobe(category: 'work');
print('Work scenes: ${workData['scenes'].length}'); // 2

// 获取约会场景
final dateData = await fetchWardrobe(category: 'date');
final scenes = dateData['scenes'] as List;
final filters = dateData['filters'] as List;

// 找到选中的过滤器
final selectedFilter = filters.firstWhere((f) => f['selected'] == true);
print('Selected: ${selectedFilter['title']}'); // "Date"
```

**注意事项**:
- 所有场景图片使用 Unsplash 作为图片源
- Premium 场景需要在客户端显示特殊标识
- 颜色调色板数组长度可变（通常 3-4 个颜色）
- 接口已启用 CORS，可从任何域名访问
- **服务器端过滤**: 使用 `category` 参数可减少传输数据量，适合移动端
- **客户端过滤**: 获取全部数据后在客户端过滤，适合需要频繁切换分类的场景
- `filters` 的 `selected` 状态会根据 `category` 参数自动更新，前端可直接使用

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

### v1.1.0 (2025-10-27)
- ✅ `/wardrobe` 端点重构
  - 模块化代码结构（handlers + data 分离）
  - 添加 `category` 查询参数支持
  - 动态过滤器选中状态
  - 输入验证和错误处理
  - 完整的 JSDoc 文档

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
