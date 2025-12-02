import 'package:supabase_flutter/supabase_flutter.dart';
import 'env_config.dart';

/// Configuración e inicialización de Supabase
class SupabaseConfig {
  static late final SupabaseClient _client;

  /// Inicializar Supabase
  static Future<void> init() async {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
      debug: EnvConfig.isDebugMode,
    );
    _client = Supabase.instance.client;
  }

  /// Obtener instancia de Supabase
  static SupabaseClient get client => _client;

  /// Acceso directo a auth
  static dynamic get auth => _client.auth;

  /// Acceso directo a database (via from method)
  static dynamic get db => _client.from;

  /// Acceso directo a realtime
  static dynamic get realtime => _client.realtime;
}
