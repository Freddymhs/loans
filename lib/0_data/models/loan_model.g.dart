// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanModel _$LoanModelFromJson(Map<String, dynamic> json) => LoanModel(
      id: json['id'] as String,
      lenderId: json['lenderId'] as String,
      borrowerId: json['borrowerId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      description: json['description'] as String,
      loanDate: DateTime.parse(json['loanDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      interestRate: (json['interestRate'] as num?)?.toDouble(),
      status: $enumDecode(_$LoanStatusEnumMap, json['status'],
          unknownValue: LoanStatus.pending),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LoanModelToJson(LoanModel instance) => <String, dynamic>{
      'id': instance.id,
      'lenderId': instance.lenderId,
      'borrowerId': instance.borrowerId,
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'loanDate': instance.loanDate.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'interestRate': instance.interestRate,
      'status': _$LoanStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$LoanStatusEnumMap = {
  LoanStatus.pending: 'pending',
  LoanStatus.active: 'active',
  LoanStatus.completed: 'completed',
  LoanStatus.overdue: 'overdue',
  LoanStatus.cancelled: 'cancelled',
};
