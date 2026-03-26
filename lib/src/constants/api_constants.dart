const String _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:9000', // Local dev default
);

class ApiConstants {
  // -------------------------------------------------------
  // baseUrl is sourced from:
  // 1. GitHub Actions secret (API_BASE_URL) in production builds
  // 2. Fallback to local dev default for local builds
  // 
  // Example local overrides:
  // Android emulator → 'http://10.0.2.2:8000'
  // iOS simulator    → 'http://127.0.0.1:8000'
  // Physical device  → 'http://YOUR_PC_LOCAL_IP:8000'
  // -------------------------------------------------------
  static const String baseUrl = _apiBaseUrl;

  // Endpoints
  static const String register   = '$baseUrl/api/mobile/register';
  static const String login      = '$baseUrl/api/mobile/login';
  static const String logout     = '$baseUrl/api/mobile/logout';
  static const String me         = '$baseUrl/api/mobile/me';
  static const String entry      = '$baseUrl/api/mobile/entry';
  static const String surveys    = '$baseUrl/api/mobile/surveys';
  static const String categories = '$baseUrl/api/mobile/categories';
}