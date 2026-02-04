import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithGoogleRequested extends AuthEvent {
  const LoginWithGoogleRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class GetCurrentUserRequested extends AuthEvent {
  const GetCurrentUserRequested();
}

class IsSessionActiveRequested extends AuthEvent {
  const IsSessionActiveRequested();
}
