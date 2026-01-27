import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/entities/user_entity.dart';
import 'package:loans/0_domain/repositories/auth_repository.dart';
import 'package:loans/1_data/datasources/auth_datasource.dart';
import 'package:loans/1_data/datasources/token_local_datasource.dart';
import 'package:loans/3_utils/errors/failures.dart';

typedef AuthOperation<T> = Future<T> Function();

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authDataSource,
    required this.tokenDataSource,
  });

  final AuthDataSource authDataSource;
  final TokenLocalDataSource tokenDataSource;

  Future<Either<Failure, T>> _handleAuthOperation<T>(
    AuthOperation<T> operation,
  ) async {
    try {
      final result = await operation();
      return Right(result);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() {
    return _handleAuthOperation(() async {
      final userModel = await authDataSource.loginWithGoogle();
      await tokenDataSource.saveToken(userModel.id);
      return userModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> logOut() {
    return _handleAuthOperation(() async {
      await authDataSource.logOut();
      await tokenDataSource.deleteToken();
    });
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() {
    return _handleAuthOperation(() async {
      final hasToken = await tokenDataSource.hasToken();
      if (!hasToken) return null;

      final userModel = await authDataSource.getCurrentUser();
      return userModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> isSessionActive() {
    return _handleAuthOperation(() async {
      final hasToken = await tokenDataSource.hasToken();
      if (!hasToken) return false;

      return authDataSource.isSessionActive();
    });
  }
}
