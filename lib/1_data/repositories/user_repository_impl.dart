import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/entities/company_entity.dart';
import 'package:loans/0_domain/entities/user_entity.dart';
import 'package:loans/0_domain/repositories/user_repository.dart';
import 'package:loans/1_data/datasources/user_datasource.dart';
import 'package:loans/1_data/models/company_model.dart';
import 'package:loans/1_data/models/user_model.dart';
import 'package:loans/3_utils/errors/failures.dart';

typedef UserOperation<T> = Future<T> Function();

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.userDataSource});

  final UserDataSource userDataSource;

  Future<Either<Failure, T>> _handleUserOperation<T>(
    UserOperation<T> operation,
  ) async {
    try {
      final result = await operation();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUserOnboarding(UserEntity user) {
    return _handleUserOperation(() async {
      final userModel = UserModel.fromEntity(user);
      final createdModel = await userDataSource.createUserOnboarding(userModel);
      return createdModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> isRootIdAvailable(String rootId) {
    return _handleUserOperation(() async {
      return userDataSource.isRootIdAvailable(rootId);
    });
  }

  @override
  Future<Either<Failure, CompanyEntity>> createCompany(String name) {
    return _handleUserOperation(() async {
      final createdModel = await userDataSource.createCompany(name);
      return createdModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, CompanyEntity>> getCompanyByName(String name) {
    return _handleUserOperation(() async {
      final companyModel = await userDataSource.getCompanyByName(name);
      return companyModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> joinCompany(String companyId) {
    return _handleUserOperation(() async {
      await userDataSource.joinCompany(companyId);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String userId) {
    return _handleUserOperation(() async {
      final userModel = await userDataSource.getUserById(userId);
      return userModel.toEntity();
    });
  }
}
