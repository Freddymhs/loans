import 'package:loans/3_utils/string_constants.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Manejador centralizado de errores
class ErrorHandler {
  /// Mapea excepciones a Failures
  static Failure mapException(Exception exception) {
    if (exception is AuthException) {
      return AuthFailure(_getAuthErrorMessage(exception.code));
    } else if (exception is DatabaseException) {
      return DatabaseFailure(exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(AppStrings.networkError);
    } else if (exception is ValidationException) {
      return ValidationFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else if (exception is NotFoundException) {
      return NotFoundFailure(exception.message);
    } else {
      return UnknownFailure('${exception.toString()}');
    }
  }

  /// Obtiene mensaje amigable para errores de auth
  static String _getAuthErrorMessage(String? code) => switch (code) {
    'user-not-found' => 'Usuario no encontrado',
    'wrong-password' => 'Contraseña incorrecta',
    'user-disabled' => 'Usuario deshabilitado',
    'invalid-email' => 'Email inválido',
    'weak-password' => 'Contraseña muy débil',
    'email-already-in-use' => 'Email ya registrado',
    'invalid-credential' => 'Credenciales inválidas',
    'oauth-token-revoked' => 'Token expirado, intenta de nuevo',
    'oauth-invalid-grant' => 'Permiso denegado',
    _ => 'Error de autenticación',
  };

  /// Obtiene mensaje amigable para errores de BD
  static String getDatabaseErrorMessage(String? code) => switch (code) {
    '23505' => 'Este elemento ya existe',
    '23503' => 'No puedes eliminar esto, hay elementos relacionados',
    '42P01' => 'Tabla no encontrada',
    _ => 'Error en la base de datos',
  };
}
