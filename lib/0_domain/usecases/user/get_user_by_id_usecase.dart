import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/entities/user_entity.dart';
import 'package:loans/0_domain/repositories/user_repository.dart';
import 'package:loans/3_utils/errors/failures.dart';

class GetUserByIdUseCase {
  GetUserByIdUseCase({required this.userRepository});

  final UserRepository userRepository;

  Future<Either<Failure, UserEntity>> call(UserEntity user) {
    return userRepository.getUserById(user.id);
  }
}
