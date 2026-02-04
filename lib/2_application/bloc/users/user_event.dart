import 'package:equatable/equatable.dart';
import 'package:loans/0_domain/entities/user_entity.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserOnboardingRequested extends UserEvent {
  const CreateUserOnboardingRequested(this.user);

  final UserEntity user;

  @override
  List<Object?> get props => [user];
}

class IsRootIdAvailableRequested extends UserEvent {
  const IsRootIdAvailableRequested(this.rootId);
  final String rootId;

  @override
  List<Object?> get props => [rootId];
}

class CreateCompanyRequested extends UserEvent {
  const CreateCompanyRequested(this.name);
  final String name;
  @override
  List<Object?> get props => [name];
}

class GetCompanyByNameRequested extends UserEvent {
  const GetCompanyByNameRequested(this.name);
  final String name;
  @override
  List<Object?> get props => [name];
}

class JoinCompanyRequested extends UserEvent {
  const JoinCompanyRequested(this.companyId);
  final String companyId;
  @override
  List<Object?> get props => [companyId];
}

class GetUserByIdRequested extends UserEvent {
  const GetUserByIdRequested(this.user);
  final UserEntity user;
  @override
  List<Object?> get props => [user];
}
