import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/repositories/user_repository.dart';
import 'package:loans/3_utils/errors/failures.dart';

class JoinCompanyUseCase {
  JoinCompanyUseCase({required this.userRepository});

  final UserRepository userRepository;

  Future<Either<Failure, void>> call(String companyId) {
    return userRepository.joinCompany(companyId);
  }
}
