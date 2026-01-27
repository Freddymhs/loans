import 'package:json_annotation/json_annotation.dart';
import 'package:loans/0_domain/entities/company_entity.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel {
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final List<String> members;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.members,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);

  CompanyEntity toEntity() {
    return CompanyEntity(
      id: id,
      name: name,
      createdBy: createdBy,
      createdAt: createdAt,
      members: members,
    );
  }

  factory CompanyModel.fromEntity(CompanyEntity entity) {
    return CompanyModel(
      id: entity.id,
      name: entity.name,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      members: entity.members,
    );
  }
}
