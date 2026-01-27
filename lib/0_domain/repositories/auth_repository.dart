import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/entities/user_entity.dart';
import 'package:loans/3_utils/errors/failures.dart';

abstract class AuthRepository {
  /// Sign in with Google
  Future<Either<Failure, UserEntity>> loginWithGoogle();

  /// Sign out the current user
  Future<Either<Failure, void>> logOut();

  /// Get the current authenticated user
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Check if user is authenticated
  Future<Either<Failure, bool>> isSessionActive();
}
