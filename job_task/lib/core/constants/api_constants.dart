class ApiConstants {
  ApiConstants._(); // no instances

  // ── Base ───────────────────────────────────────────────────────
  static const String baseUrl = 'http://127.0.0.1:8000/api/';

  // ── Endpoints ──────────────────────────────────────────────────
  static const String products  = 'products';
  static const String login = 'auth/login';
  static const String forgotPassword = 'auth/forgot-password';

  // ── Headers ────────────────────────────────────────────────────
  static const String acceptHeader = 'application/json';
  static const String contentType  = 'application/json';
  static const String bearerPrefix = 'Bearer ';

  // ── Keys ───────────────────────────────────────────────────────
  static const String refreshTokenKey = 'refresh_token';

  // ── Timeouts ───────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout    = Duration(seconds: 30);


}