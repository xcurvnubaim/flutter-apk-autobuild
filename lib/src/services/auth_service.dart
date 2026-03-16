import 'package:welangflood/src/constants/api_constants.dart';
import 'package:welangflood/src/services/api_service.dart';

class AuthResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? user;

  AuthResult({required this.success, required this.message, this.user});
}

class AuthService {
  // -------------------------------------------------------
  // Register
  // -------------------------------------------------------

  static Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(ApiConstants.register, {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response['status'] == 'success') {
      final token = response['data']['token'] as String;
      await ApiService.saveToken(token);
      return AuthResult(
        success: true,
        message: response['message'] ?? 'Registrasi berhasil',
        user: response['data']['user'] as Map<String, dynamic>?,
      );
    }

    return AuthResult(
      success: false,
      message: response['message'] ?? 'Registrasi gagal',
    );
  }

  // -------------------------------------------------------
  // Login
  // -------------------------------------------------------

  static Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(ApiConstants.login, {
      'email': email,
      'password': password,
    });

    if (response['status'] == 'success') {
      final token = response['data']['token'] as String;
      await ApiService.saveToken(token);
      return AuthResult(
        success: true,
        message: response['message'] ?? 'Login berhasil',
      );
    }

    return AuthResult(
      success: false,
      message: response['message'] ?? 'Email atau password salah',
    );
  }

  // -------------------------------------------------------
  // Logout
  // -------------------------------------------------------

  static Future<AuthResult> logout() async {
    final response = await ApiService.post(
      ApiConstants.logout,
      {},
      requiresAuth: true,
    );

    // Always clear local token regardless of server response
    await ApiService.clearToken();

    return AuthResult(
      success: true,
      message: response['message'] ?? 'Logout berhasil',
    );
  }

  // -------------------------------------------------------
  // Get current user
  // -------------------------------------------------------

  static Future<Map<String, dynamic>?> me() async {
    final response = await ApiService.get(ApiConstants.me);
    if (response['status'] == 'success') {
      return response['data']['user'] as Map<String, dynamic>?;
    }
    return null;
  }

  // -------------------------------------------------------
  // Auth guard
  // -------------------------------------------------------

  static Future<bool> isLoggedIn() => ApiService.hasToken();
}