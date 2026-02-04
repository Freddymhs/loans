import 'package:equatable/equatable.dart';

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
