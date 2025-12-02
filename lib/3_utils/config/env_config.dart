import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuración de variables de entorno
class EnvConfig {
  static String? _supabaseUrl;
  static String? _supabaseAnonKey;
  static String? _googleWebClientId;
  static String? _googleIosClientId;
  static String? _googleAndroidClientId;
  static String? _appEnv;
  static bool? _debugMode;

  /// Inicializar configuración desde .env
  static Future<void> init() async {
    await dotenv.load();
    _supabaseUrl = dotenv.env['SUPABASE_URL'];
    _supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
    _googleWebClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
    _googleIosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID'];
    _googleAndroidClientId = dotenv.env['GOOGLE_ANDROID_CLIENT_ID'];
    _appEnv = dotenv.env['APP_ENV'] ?? 'development';
    _debugMode = dotenv.env['DEBUG_MODE'] == 'true';
  }

  // Getters
  static String get supabaseUrl => _supabaseUrl ?? '';
  static String get supabaseAnonKey => _supabaseAnonKey ?? '';
  static String get googleWebClientId => _googleWebClientId ?? '';
  static String get googleIosClientId => _googleIosClientId ?? '';
  static String get googleAndroidClientId => _googleAndroidClientId ?? '';
  static String get appEnv => _appEnv ?? 'development';
  static bool get isProduction => _appEnv == 'production';
  static bool get isDebugMode => _debugMode ?? false;

  // Validación
  static bool get isConfigured =>
      _supabaseUrl != null &&
      _supabaseUrl!.isNotEmpty &&
      _supabaseAnonKey != null &&
      _supabaseAnonKey!.isNotEmpty;
}
