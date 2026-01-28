import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/repositories/auth_repository.dart';
import 'package:loans/3_utils/errors/failures.dart';

class IsSessionActiveUseCase {
  IsSessionActiveUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<Either<Failure, bool>> call() {
    return authRepository.isSessionActive();
  }
}
