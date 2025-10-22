import 'dart:convert';
import 'dart:math';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// JWT Payload structure corresponding to MyJWTPayload in Swift
class MyJWTPayload {
  final String userId;
  final String token;
  final double exp;

  MyJWTPayload({
    required this.userId,
    required this.token,
    required this.exp,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'exp': exp,
      'user_id': userId,
    };
  }

  factory MyJWTPayload.fromJson(Map<String, dynamic> json) {
    return MyJWTPayload(
      userId: json['user_id'] as String,
      token: json['token'] as String,
      exp: (json['exp'] as num).toDouble(),
    );
  }
}

/// JWT Manager utility class for generating and managing JWT tokens
class JWTManager {
  static final JWTManager _instance = JWTManager._internal();
  factory JWTManager() => _instance;
  JWTManager._internal();

  /// Shared singleton instance
  static JWTManager get shared => _instance;

  static const String _uuidKey = "user_uuid";

  /// Encrypted JWT key - simple obfuscation
  static const String _encryptedKey =
      "Q1F4T1BLVGJNUVUxb0V0ZHNEVjFJS0o1VXhmQXRFODk=";

  /// Get decoded JWT key
  String get _jwtKey {
    try {
      return utf8.decode(base64.decode(_encryptedKey));
    } catch (e) {
      // Fallback to original key if decoding fails
      return "CQxOPKTbMQU1oEtdsDV1IKJ5UxfAtE89";
    }
  }

  /// Get expiration timestamp (current time + 60 minutes)
  double get _exp {
    final now = DateTime.now();
    final expTime = now.add(const Duration(minutes: 60));
    return expTime.millisecondsSinceEpoch /
        1000.0; // Convert to seconds with decimal
  }

  /// Generate a proper UUID string in the format: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
  String _generateUUID() {
    final random = Random();

    String toHex(int value, int length) {
      return value.toRadixString(16).toUpperCase().padLeft(length, '0');
    }

    final a = random.nextInt(0x100000000);
    final b = random.nextInt(0x10000);
    final c = (random.nextInt(0x1000) | 0x4000); // Version 4
    final d = (random.nextInt(0x4000) | 0x8000); // Variant 1

    // Generate the last part (12 hex digits = 48 bits) in two parts to avoid overflow
    // Split into two 24-bit (6 hex digits) parts
    final e1 = random.nextInt(0x1000000); // First 6 hex digits
    final e2 = random.nextInt(0x1000000); // Last 6 hex digits

    return '${toHex(a, 8)}-${toHex(b, 4)}-${toHex(c, 4)}-${toHex(d, 4)}-${toHex(e1, 6)}${toHex(e2, 6)}';
  }

  /// Get or generate UUID from SharedPreferences
  Future<String> get _uuid async {
    final prefs = await SharedPreferences.getInstance();
    String? storedUuid = prefs.getString(_uuidKey);

    if (storedUuid == null) {
      // Generate timestamp with decimal seconds
      final now = DateTime.now();
      final timestampSeconds = now.millisecondsSinceEpoch / 1000.0;

      // Generate UUID
      final uuid = _generateUUID();

      // Format: "timestamp_UUID"
      storedUuid = '${timestampSeconds}_$uuid';
      await prefs.setString(_uuidKey, storedUuid);

      print('🆔 JWTManager: Generated new user_id: $storedUuid');
    }

    return storedUuid;
  }

  /// Generate API key (JWT token)
  Future<String?> get apiKey async {
    try {
      final uuid = await _uuid;
      final exp = _exp;
      final payload = MyJWTPayload(
        userId: uuid,
        token: "admin",
        exp: exp,
      );

      print('🔐 JWTManager: Creating JWT with payload:');
      print('   Payload JSON: ${payload.toJson()}');
      print('   - token: ${payload.token}');
      print('   - exp: ${payload.exp}');
      print('   - user_id: ${payload.userId}');

      final jwtString = _generateJWT(payload);
      print("✅ JWTManager: Encoded JWT: $jwtString");

      // Debug: Decode and verify the payload
      _debugDecodeJWT(jwtString);

      return jwtString;
    } catch (error) {
      print("❌ JWTManager: JWT Encoding Error: $error");
      return null;
    }
  }

  /// Generate JWT token using dart_jsonwebtoken library
  String _generateJWT(MyJWTPayload payload) {
    // Create JWT token with standard header (includes "typ": "JWT")
    final jwt = JWT(payload.toJson());

    // Sign with HMAC SHA256, keep automatic iat field
    final token = jwt.sign(SecretKey(_jwtKey));
    print('🔍 JWTManager: JWT Token: $token');

    return token;
  }

  /// Verify JWT token (optional utility method)
  bool verifyToken(String token) {
    try {
      JWT.verify(token, SecretKey(_jwtKey));
      return true;
    } catch (e) {
      print("JWT Verification Error: $e");
      return false;
    }
  }

  /// Decode JWT payload (optional utility method)
  MyJWTPayload? decodePayload(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_jwtKey));
      return MyJWTPayload.fromJson(jwt.payload as Map<String, dynamic>);
    } catch (e) {
      print("JWT Decode Error: $e");
      return null;
    }
  }

  /// Check if token is expired
  bool isTokenExpired(String token) {
    final payload = decodePayload(token);
    if (payload == null) return true;

    final now = DateTime.now().millisecondsSinceEpoch / 1000.0;
    return payload.exp < now;
  }

  /// Debug method to decode and inspect JWT
  void _debugDecodeJWT(String token) {
    try {
      final parts = token.split('.');
      if (parts.length == 3) {
        // Decode payload
        final payloadBytes = base64Url.decode(base64Url.normalize(parts[1]));
        final payloadString = utf8.decode(payloadBytes);
        final payload = jsonDecode(payloadString);

        print('🔍 JWTManager: Decoded payload:');
        print('   $payload');

        // Check for standard JWT fields
        if (payload.containsKey('iat')) {
          print('📅 JWT contains iat field: ${payload['iat']}');
        }
        if (payload.containsKey('nbf')) {
          print('📅 JWT contains nbf field: ${payload['nbf']}');
        }

        // Verify required fields
        final hasToken = payload.containsKey('token');
        final hasExp = payload.containsKey('exp');
        final hasUserId = payload.containsKey('user_id');

        print('✅ Required fields check:');
        print(
            '   - token: $hasToken (${hasToken ? payload['token'] : 'missing'})');
        print('   - exp: $hasExp (${hasExp ? payload['exp'] : 'missing'})');
        print(
            '   - user_id: $hasUserId (${hasUserId ? payload['user_id'] : 'missing'})');
      }
    } catch (e) {
      print('❌ JWTManager: Failed to debug decode JWT: $e');
    }
  }

  /// Clear stored UUID (for testing or logout)
  Future<void> clearStoredUuid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_uuidKey);
  }
}
