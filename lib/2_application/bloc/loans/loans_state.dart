import 'package:equatable/equatable.dart';
import 'package:loans/0_domain/entities/loan_entity.dart';

abstract class LoansState extends Equatable {
  const LoansState();

  @override
  List<Object?> get props => [];
}

class LoansInitial extends LoansState {
  const LoansInitial();
}

class LoansLoading extends LoansState {
  const LoansLoading();
}

class LoansLoaded extends LoansState {
  final List<LoanEntity> loans;

  const LoansLoaded(this.loans);

  int get activeCount =>
      loans.where((l) => l.status == LoanStatus.active).length;
  int get pendingCount =>
      loans.where((l) => l.status == LoanStatus.pending).length;

  int outgoingCount(String userId) =>
      loans.where((l) => l.lenderId == userId).length;
  int incomingCount(String userId) =>
      loans.where((l) => l.borrowerId == userId).length;

  List<LoanEntity> getOutgoingLoans(String userId) =>
      loans.where((l) => l.lenderId == userId).toList();
  List<LoanEntity> getIncomingLoans(String userId) =>
      loans.where((l) => l.borrowerId == userId).toList();

  @override
  List<Object?> get props => [loans];
}

class LoansError extends LoansState {
  final String message;

  const LoansError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoanMarkedAsReturned extends LoansState {
  final LoanEntity loan;

  const LoanMarkedAsReturned(this.loan);

  @override
  List<Object?> get props => [loan];
}

class LoanCreated extends LoansState {
  final LoanEntity loan;

  const LoanCreated(this.loan);

  @override
  List<Object?> get props => [loan];
}

class LoanUpdated extends LoansState {
  final LoanEntity loan;

  const LoanUpdated(this.loan);

  @override
  List<Object?> get props => [loan];
}

class LoanDeleted extends LoansState {
  final String loanId;

  const LoanDeleted(this.loanId);

  @override
  List<Object?> get props => [loanId];
}
