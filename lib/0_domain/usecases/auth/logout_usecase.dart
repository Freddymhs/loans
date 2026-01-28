import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/repositories/auth_repository.dart';
import 'package:loans/3_utils/errors/failures.dart';

class LogoutUseCase {
  LogoutUseCase({required this.authRepository});

  final AuthRepository authRepository;


  Future<Either<Failure, void>> call() {
    return authRepository.logOut();
  }
}
