import 'package:get_it/get_it.dart';
import 'package:loans/3_utils/config/env_config.dart';
import 'package:loans/3_utils/config/supabase_config.dart';
import 'package:loans/2_application/bloc/theme/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

/// Configurar todas las dependencias de la aplicación
Future<void> setupServiceLocator() async {
  // ============ CORE ============

  // Cargar variables de entorno
  await EnvConfig.init();

  // Inicializar Supabase
  await SupabaseConfig.init();

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // ============ CUBITS/BLOCS ============

  getIt.registerSingleton(ThemeCubit());

  // TODO: Agregar más BLoCs aquí cuando estén implementados
  // getIt.registerSingleton(AuthBloc(...));
  // getIt.registerSingleton(LendsBloc(...));
  // getIt.registerSingleton(FilterBloc(...));

  // ============ REPOSITORIES ============

  // TODO: Agregar repositorios aquí
  // getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(...));
  // getIt.registerSingleton<LendsRepository>(LendsRepositoryImpl(...));

  // ============ DATA SOURCES ============

  // TODO: Agregar data sources aquí
  // getIt.registerSingleton<FirebaseAuthDataSource>(FirebaseAuthDataSourceImpl(...));
  // getIt.registerSingleton<LendsLocalDataSource>(LendsLocalDataSourceImpl(...));

  // ============ USE CASES ============

  // TODO: Agregar use cases aquí
  // getIt.registerSingleton(GoogleSignInUseCase(getIt()));
  // getIt.registerSingleton(GetLendsUseCase(getIt()));
}
