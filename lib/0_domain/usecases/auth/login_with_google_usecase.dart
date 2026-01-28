import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/entities/user_entity.dart';
import 'package:loans/0_domain/repositories/auth_repository.dart';
import 'package:loans/3_utils/errors/failures.dart';

class LoginWithGoogleUseCase {
  LoginWithGoogleUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<Either<Failure, UserEntity>> call() {
    return authRepository.loginWithGoogle();
  }
}
