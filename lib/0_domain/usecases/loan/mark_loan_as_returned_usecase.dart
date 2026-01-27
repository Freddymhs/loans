import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loans/0_domain/entities/loan_entity.dart';
import 'package:loans/0_domain/repositories/loan_repository.dart';
import 'package:loans/0_domain/usecases/base_usecase.dart';
import 'package:loans/3_utils/errors/failures.dart';

class MarkLoanAsReturnedParams extends Equatable {
  final String loanId;

  const MarkLoanAsReturnedParams(this.loanId);

  @override
  List<Object?> get props => [loanId];
}

class MarkLoanAsReturnedUseCase
    extends UseCase<LoanEntity, MarkLoanAsReturnedParams> {
  final LoanRepository repository;

  MarkLoanAsReturnedUseCase(this.repository);

  @override
  Future<Either<Failure, LoanEntity>> call(MarkLoanAsReturnedParams params) {
    return repository.markAsReturned(params.loanId);
  }
}
