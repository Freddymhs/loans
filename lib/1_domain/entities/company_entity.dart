import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final List<String> members;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.members,
  });

  @override
  List<Object?> get props => [id, name, createdBy, createdAt, members];
}
