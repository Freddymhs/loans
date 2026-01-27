import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loans/0_domain/entities/loan_entity.dart';
import 'package:loans/0_domain/repositories/loan_repository.dart';
import 'package:loans/0_domain/usecases/base_usecase.dart';
import 'package:loans/3_utils/errors/failures.dart';

class CreateLoanParams extends Equatable {
  final String lenderId;
  final String borrowerId;
  final double amount;
  final String currency;
  final String description;
  final DateTime loanDate;
  final DateTime dueDate;
  final double? interestRate;

  const CreateLoanParams({
    required this.lenderId,
    required this.borrowerId,
    required this.amount,
    required this.currency,
    required this.description,
    required this.loanDate,
    required this.dueDate,
    this.interestRate,
  });

  @override
  List<Object?> get props => [
        lenderId,
        borrowerId,
        amount,
        currency,
        description,
        loanDate,
        dueDate,
        interestRate,
      ];
}

class CreateLoanUseCase extends UseCase<LoanEntity, CreateLoanParams> {
  final LoanRepository repository;

  CreateLoanUseCase(this.repository);

  @override
  Future<Either<Failure, LoanEntity>> call(CreateLoanParams params) {
    final loan = LoanEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      lenderId: params.lenderId,
      borrowerId: params.borrowerId,
      amount: params.amount,
      currency: params.currency,
      description: params.description,
      loanDate: params.loanDate,
      dueDate: params.dueDate,
      interestRate: params.interestRate,
      status: LoanStatus.active,
      createdAt: DateTime.now(),
    );

    return repository.createLoan(loan);
  }
}
