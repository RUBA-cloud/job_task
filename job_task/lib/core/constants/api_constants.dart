class ApiConstants {
  ApiConstants._(); // no instances

  // ── Base ───────────────────────────────────────────────────────
  static const String baseUrl = 'https://fakestoreapi.com/';

  // ── Endpoints ──────────────────────────────────────────────────
  static const String products  = 'products';


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