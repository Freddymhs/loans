import 'package:dartz/dartz.dart';
import 'package:loans/0_domain/entities/company_entity.dart';
import 'package:loans/0_domain/repositories/user_repository.dart';
import 'package:loans/3_utils/errors/failures.dart';

class GetCompanyByNameUseCase {
  GetCompanyByNameUseCase({required this.userRepository});

  final UserRepository userRepository;

  Future<Either<Failure, CompanyEntity>> call(String name) {
    return userRepository.getCompanyByName(name);
  }
}
