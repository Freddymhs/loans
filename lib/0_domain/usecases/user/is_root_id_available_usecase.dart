import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/repositories/user_repository.dart';
import 'package:loans/3_utils/errors/failures.dart';

class IsRootIdAvailableUseCase {
  IsRootIdAvailableUseCase({required this.userRepository});

  final UserRepository userRepository;

  Future<Either<Failure, bool>> call(String rootId) {
    return userRepository.isRootIdAvailable(rootId);
  }
}
