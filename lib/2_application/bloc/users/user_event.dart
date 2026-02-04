import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserOnboardingRequested extends UserEvent {
  const CreateUserOnboardingRequested(this.rootId);
  final String rootId;

  @override
  List<Object?> get props => [rootId];
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
  const JoinCompanyRequested(this.companyName);
  final String companyName;
  @override
  List<Object?> get props => [companyName];
}

class GetUserByIdRequested extends UserEvent {
  const GetUserByIdRequested(this.userId);
  final String userId;
  @override
  List<Object?> get props => [userId];
}
