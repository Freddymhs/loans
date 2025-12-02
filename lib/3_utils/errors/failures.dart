import 'package:equatable/equatable.dart';

/// Base class para todos los failures (errores)
sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error de autenticación
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Error de base de datos
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Error de validación
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Error de red
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Error desconocido
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

/// Error de caché
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Error de no encontrado
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
