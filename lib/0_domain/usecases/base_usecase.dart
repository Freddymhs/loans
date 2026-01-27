import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loans/3_utils/errors/failures.dart';

/// Clase base para todos los use cases
///
/// Proporciona una interfaz consistente para todos los use cases
/// Type parameters:
/// - [T]: El tipo de dato que retorna en caso de éxito
/// - [Params]: Los parámetros que recibe el use case
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use case que no recibe parámetros
abstract class UseCaseWithoutParams<T> {
  Future<Either<Failure, T>> call();
}

/// Parámetros vacíos (para use cases sin parámetros)
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
