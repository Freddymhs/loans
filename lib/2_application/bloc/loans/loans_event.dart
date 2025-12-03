import 'package:equatable/equatable.dart';
import 'package:loans/1_domain/entities/loan_entity.dart';

abstract class LoansEvent extends Equatable {
  const LoansEvent();

  @override
  List<Object?> get props => [];
}

class LoadLoansEvent extends LoansEvent {
  final String? userId;

  const LoadLoansEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class MarkLoanAsReturnedEvent extends LoansEvent {
  final String loanId;

  const MarkLoanAsReturnedEvent(this.loanId);

  @override
  List<Object?> get props => [loanId];
}

class CreateLoanEvent extends LoansEvent {
  final LoanEntity loan;

  const CreateLoanEvent(this.loan);

  @override
  List<Object?> get props => [loan];
}

class UpdateLoanEvent extends LoansEvent {
  final LoanEntity loan;

  const UpdateLoanEvent(this.loan);

  @override
  List<Object?> get props => [loan];
}

class DeleteLoanEvent extends LoansEvent {
  final String loanId;

  const DeleteLoanEvent(this.loanId);

  @override
  List<Object?> get props => [loanId];
}
