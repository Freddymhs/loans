import 'package:equatable/equatable.dart';
import 'package:loans/0_domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  const Authenticated(this.user); // se necesita del user

  final UserEntity user; // guarda el user

  @override
  List<Object?> get props => [user]; //compara por user
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.message); //necesita mensaje

  final String message; // guarda mensaje

  @override
  List<Object?> get props => [message]; //compara por mensaje
}
