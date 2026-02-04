import 'package:equatable/equatable.dart';
import 'package:loans/0_domain/entities/company_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

/// Éxito sin payload; para operaciones que solo confirman completion.
class UserSuccess extends UserState {
  const UserSuccess();
}

class UserError extends UserState {
  const UserError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Resultado de chequear disponibilidad de rootId.
class RootIdAvailabilityState extends UserState {
  const RootIdAvailabilityState(this.isAvailable);

  final bool isAvailable;

  @override
  List<Object?> get props => [isAvailable];
}

class CompanyLoadedState extends UserState {
  const CompanyLoadedState(this.company);
  final CompanyEntity company;

  @override
  List<Object?> get props => [company];
}
