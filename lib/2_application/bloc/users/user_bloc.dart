import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans/0_domain/usecases/user/create_company_usecase.dart';
import 'package:loans/0_domain/usecases/user/create_user_onboarding_usecase.dart';
import 'package:loans/0_domain/usecases/user/get_company_by_name_usecase.dart';
import 'package:loans/0_domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:loans/0_domain/usecases/user/is_root_id_available_usecase.dart';
import 'package:loans/0_domain/usecases/user/join_company_usecase.dart';
import 'package:loans/2_application/bloc/users/user_event.dart';
import 'package:loans/2_application/bloc/users/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required this.createUserOnboardingUseCase,
    required this.isRootIdAvailableUseCase,
    required this.createCompanyUseCase,
    required this.getCompanyByNameUseCase,
    required this.joinCompanyUseCase,
    required this.getUserByIdUseCase,
  }) : super(const UserInitial()) {
    on<CreateUserOnboardingRequested>(_onCreateUserOnboardingRequested);
    on<IsRootIdAvailableRequested>(_onIsRootIdAvailableRequested);
    on<CreateCompanyRequested>(_onCreateCompanyRequested);
    on<GetCompanyByNameRequested>(_onGetCompanyByNameRequested);
    on<JoinCompanyRequested>(_onJoinCompanyRequested);
    on<GetUserByIdRequested>(_onGetUserByIdRequested);
  }

  final CreateUserOnboardingUseCase createUserOnboardingUseCase;
  final IsRootIdAvailableUseCase isRootIdAvailableUseCase;
  final CreateCompanyUseCase createCompanyUseCase;
  final GetCompanyByNameUseCase getCompanyByNameUseCase;
  final JoinCompanyUseCase joinCompanyUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;

  Future<void> _onCreateUserOnboardingRequested(
    CreateUserOnboardingRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await createUserOnboardingUseCase(event.user);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(const UserSuccess()),
    );
  }

  Future<void> _onIsRootIdAvailableRequested(
    IsRootIdAvailableRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await isRootIdAvailableUseCase.call(event.rootId);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (isAvailable) => emit(RootIdAvailabilityState(isAvailable)),
    );
  }

  Future<void> _onCreateCompanyRequested(
    CreateCompanyRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await createCompanyUseCase(event.name);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(const UserSuccess()),
    );
  }

  Future<void> _onGetCompanyByNameRequested(
    GetCompanyByNameRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await getCompanyByNameUseCase(event.name);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (company) => emit(CompanyLoadedState(company)),
    );
  }

  Future<void> _onJoinCompanyRequested(
    JoinCompanyRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await joinCompanyUseCase(event.companyId);
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(const UserSuccess()),
    );
  }

  Future<void> _onGetUserByIdRequested(
    GetUserByIdRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await getUserByIdUseCase(event.user);
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(const UserSuccess()),
    );
  }
}
