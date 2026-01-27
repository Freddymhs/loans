import 'package:json_annotation/json_annotation.dart';
import 'package:loans/1_domain/entities/loan_entity.dart';

part 'loan_model.g.dart';

@JsonSerializable()
class LoanModel {
  final String id;
  final String lenderId;
  final String borrowerId;
  final double amount;
  final String currency;
  final String description;
  final DateTime loanDate;
  final DateTime dueDate;
  final double? interestRate;

  @JsonKey(unknownEnumValue: LoanStatus.pending)
  final LoanStatus status;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const LoanModel({
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

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanModelToJson(this);

  LoanEntity toEntity() {
    return LoanEntity(
      id: id,
      lenderId: lenderId,
      borrowerId: borrowerId,
      amount: amount,
      currency: currency,
      description: description,
      loanDate: loanDate,
      dueDate: dueDate,
      interestRate: interestRate,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory LoanModel.fromEntity(LoanEntity entity) {
    return LoanModel(
      id: entity.id,
      lenderId: entity.lenderId,
      borrowerId: entity.borrowerId,
      amount: entity.amount,
      currency: entity.currency,
      description: entity.description,
      loanDate: entity.loanDate,
      dueDate: entity.dueDate,
      interestRate: entity.interestRate,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  LoanModel copyWith({
    String? id,
    String? lenderId,
    String? borrowerId,
    double? amount,
    String? currency,
    String? description,
    DateTime? loanDate,
    DateTime? dueDate,
    double? interestRate,
    LoanStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LoanModel(
      id: id ?? this.id,
      lenderId: lenderId ?? this.lenderId,
      borrowerId: borrowerId ?? this.borrowerId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      loanDate: loanDate ?? this.loanDate,
      dueDate: dueDate ?? this.dueDate,
      interestRate: interestRate ?? this.interestRate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
