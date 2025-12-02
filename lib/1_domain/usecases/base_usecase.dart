import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loans/3_utils/errors/failures.dart';

/// Clase base para todos los use cases
///
/// Proporciona una interfaz consistente para todos los use cases
/// Type parameters:
/// - [Type]: El tipo de dato que retorna en caso de éxito
/// - [Params]: Los parámetros que recibe el use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case que no recibe parámetros
abstract class UseCaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// Parámetros vacíos (para use cases sin parámetros)
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
