import 'package:get_it/get_it.dart';
import 'package:loans/1_data/datasources/loan_datasource.dart';
import 'package:loans/1_data/datasources/loan_local_datasource.dart';
import 'package:loans/1_data/models/loan_model.dart';
import 'package:loans/1_data/repositories/loan_repository_impl.dart';
import 'package:loans/0_domain/entities/loan_entity.dart';
import 'package:loans/0_domain/repositories/loan_repository.dart';
import 'package:loans/0_domain/usecases/loan/create_loan_usecase.dart';
import 'package:loans/0_domain/usecases/loan/get_loans_usecase.dart';
import 'package:loans/0_domain/usecases/loan/mark_loan_as_returned_usecase.dart';
import 'package:loans/2_application/bloc/loans/loans_bloc.dart';
import 'package:loans/2_application/bloc/theme/theme_cubit.dart';
import 'package:loans/3_utils/config/env_config.dart';
import 'package:loans/3_utils/config/supabase_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await EnvConfig.init();
  await SupabaseConfig.init();

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton<LoanDataSource>(
    _MockLoanDataSource(),
  );

  getIt.registerSingleton<LoanLocalDataSource>(
    _MockLoanLocalDataSource(),
  );

  getIt.registerSingleton<LoanRepository>(
    LoanRepositoryImpl(
      remoteDataSource: getIt<LoanDataSource>(),
      localDataSource: getIt<LoanLocalDataSource>(),
    ),
  );

  getIt.registerSingleton(
    GetLoansUseCase(getIt<LoanRepository>()),
  );

  getIt.registerSingleton(
    CreateLoanUseCase(getIt<LoanRepository>()),
  );

  getIt.registerSingleton(
    MarkLoanAsReturnedUseCase(getIt<LoanRepository>()),
  );

  getIt.registerSingleton(ThemeCubit());

  getIt.registerSingleton(
    LoansBloc(
      getLoansUseCase: getIt<GetLoansUseCase>(),
      createLoanUseCase: getIt<CreateLoanUseCase>(),
      markLoanAsReturnedUseCase: getIt<MarkLoanAsReturnedUseCase>(),
    ),
  );
}

class _MockLoanDataSource implements LoanDataSource {
  @override
  Future<List<LoanModel>> getLoans(String userId) async {
    return [];
  }

  @override
  Future<LoanModel> createLoan(LoanModel loan) async {
    return loan;
  }

  @override
  Future<LoanModel> updateLoan(String loanId, LoanModel loan) async {
    return loan;
  }

  @override
  Future<void> deleteLoan(String loanId) async {}

  @override
  Future<LoanModel> markAsReturned(String loanId) async {
    return LoanModel(
      id: loanId,
      lenderId: '',
      borrowerId: '',
      amount: 0,
      currency: '',
      description: '',
      loanDate: DateTime.now(),
      dueDate: DateTime.now(),
      status: LoanStatus.completed,
      createdAt: DateTime.now(),
    );
  }
}

class _MockLoanLocalDataSource implements LoanLocalDataSource {
  @override
  Future<void> cacheLoans(List<LoanModel> loans) async {}

  @override
  Future<List<LoanModel>> getCachedLoans() async {
    return [];
  }

  @override
  Future<void> clearCache() async {}

  @override
  Future<bool> isCacheValid() async {
    return false;
  }

  @override
  Future<void> cacheLoan(LoanModel loan) async {}

  @override
  Future<LoanModel?> getCachedLoan(String loanId) async {
    return null;
  }
}
