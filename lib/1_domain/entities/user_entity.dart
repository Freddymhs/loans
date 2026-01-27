import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final DateTime createdAt;
  final String? rootId; //? why is required?????????
  final String? companyId;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.createdAt,
    this.rootId, //?ni idea si esto debe ser required
    this.companyId, //?ni idea si esto debe ser required
  });

  @override
  List<Object?> get props =>
      [id, email, name, avatarUrl, createdAt, rootId, companyId];
}
