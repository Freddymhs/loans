import 'package:dartz/dartz.dart';
import 'package:loans/1_domain/entities/loan_entity.dart';
import 'package:loans/1_domain/repositories/loan_repository.dart';
import 'package:loans/1_domain/usecases/base_usecase.dart';
import 'package:loans/3_utils/errors/failures.dart';

class GetLoansUseCase extends UseCaseWithoutParams<List<LoanEntity>> {
  final LoanRepository repository;

  GetLoansUseCase(this.repository);

  @override
  Future<Either<Failure, List<LoanEntity>>> call() {
    return repository.getLoans();
  }
}
