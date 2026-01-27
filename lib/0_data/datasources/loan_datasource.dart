import 'package:loans/0_data/models/loan_model.dart';

abstract class LoanDataSource {
  Future<List<LoanModel>> getLoans(String userId);

  Future<LoanModel> createLoan(LoanModel loan);

  Future<LoanModel> updateLoan(String loanId, LoanModel loan);

  Future<void> deleteLoan(String loanId);

  Future<LoanModel> markAsReturned(String loanId);
}
