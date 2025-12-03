import 'package:dartz/dartz.dart';
import 'package:loans/1_domain/entities/loan_entity.dart';
import 'package:loans/3_utils/errors/failures.dart';

abstract class LoanRepository {
  Future<Either<Failure, List<LoanEntity>>> getLoans();

  Future<Either<Failure, LoanEntity>> getLoanById(String id);

  Future<Either<Failure, LoanEntity>> createLoan(LoanEntity loan);

  Future<Either<Failure, LoanEntity>> updateLoan(LoanEntity loan);

  Future<Either<Failure, void>> deleteLoan(String loanId);

  Future<Either<Failure, LoanEntity>> markAsReturned(String loanId);
}
