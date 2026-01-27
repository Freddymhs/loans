import 'package:json_annotation/json_annotation.dart';
import 'package:loans/1_domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final DateTime createdAt;
  final String? rootId;
  final String? companyId;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.createdAt,
    this.rootId,
    this.companyId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        email: email,
        createdAt: createdAt,
        rootId: rootId,
        companyId: companyId,
        name: name,
        avatarUrl: avatarUrl);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      avatarUrl: entity.avatarUrl,
      createdAt: entity.createdAt,
      rootId: entity.rootId,
      companyId: entity.companyId,
    );
  }
}
