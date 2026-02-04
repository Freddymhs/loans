import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans/0_domain/usecases/auth/get_current_user_usecase.dart';
import 'package:loans/0_domain/usecases/auth/login_with_google_usecase.dart';
import 'package:loans/0_domain/usecases/auth/logout_usecase.dart';
import 'package:loans/0_domain/usecases/auth/is_session_active_usecase.dart';
import 'package:loans/2_application/bloc/auth/auth_event.dart';
import 'package:loans/2_application/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.getCurrentUserUseCase,
    required this.isSessionActiveUseCase,
    required this.loginWithGoogleUseCase,
    required this.logoutUseCase,
  }) : super(const AuthInitial()) {
    on<LoginWithGoogleRequested>(_onLoginWithGoogleRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<GetCurrentUserRequested>(_onGetCurrentUserRequested);
    on<IsSessionActiveRequested>(_onIsSessionActiveRequested);
  }

  final GetCurrentUserUseCase getCurrentUserUseCase;
  final IsSessionActiveUseCase isSessionActiveUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;

  Future<void> _onLoginWithGoogleRequested(
    LoginWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result =
        await loginWithGoogleUseCase.call(); // sin call igualmente funciona

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const Unauthenticated()),
    );
  }

  Future<void> _onGetCurrentUserRequested(
    GetCurrentUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await getCurrentUserUseCase();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) =>
          emit(user != null ? Authenticated(user) : const Unauthenticated()),
    );
  }

  Future<void> _onIsSessionActiveRequested(
    IsSessionActiveRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await isSessionActiveUseCase();

    await result.fold<Future<void>>(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (isActive) async {
        if (!isActive) {
          emit(const Unauthenticated());
          return;
        }

        final currentUserResult = await getCurrentUserUseCase();

        currentUserResult.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(
              user != null ? Authenticated(user) : const Unauthenticated()),
        );
      },
    );
  }
}
