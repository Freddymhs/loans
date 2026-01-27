import 'package:loans/1_data/models/loan_model.dart';

abstract class LoanLocalDataSource {
  Future<void> cacheLoans(List<LoanModel> loans);

  Future<List<LoanModel>> getCachedLoans();

  Future<void> clearCache();

  Future<bool> isCacheValid();

  Future<void> cacheLoan(LoanModel loan);

  Future<LoanModel?> getCachedLoan(String loanId);
}
