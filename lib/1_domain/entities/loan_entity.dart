import 'package:equatable/equatable.dart';

enum LoanStatus { pending, active, completed, overdue, cancelled }

class LoanEntity extends Equatable {
  final String id;
  final String lenderId;
  final String borrowerId;
  final double amount;
  final String currency;
  final String description;
  final DateTime loanDate;
  final DateTime dueDate;
  final double? interestRate;
  final LoanStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LoanEntity({
    required this.id,
    required this.lenderId,
    required this.borrowerId,
    required this.amount,
    required this.currency,
    required this.description,
    required this.loanDate,
    required this.dueDate,
    this.interestRate,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        lenderId,
        borrowerId,
        amount,
        currency,
        description,
        loanDate,
        dueDate,
        interestRate,
        status,
        createdAt,
        updatedAt,
      ];
}
