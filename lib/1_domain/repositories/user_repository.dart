import 'package:dartz/dartz.dart';
import 'package:loans/1_domain/entities/company_entity.dart';
import 'package:loans/1_domain/entities/user_entity.dart';
import 'package:loans/3_utils/errors/failures.dart';

abstract class UserRepository {
  /// Create user onboarding profile
  Future<Either<Failure, UserEntity>> createUserOnboarding(UserEntity user);

  /// Check if root ID is available
  Future<Either<Failure, bool>> isRootIdAvailable(String rootId);

  /// Create a new company
  Future<Either<Failure, CompanyEntity>> createCompany(CompanyEntity company);

  /// Get company by name
  Future<Either<Failure, CompanyEntity>> getCompanyByName(String name);

  /// Join an existing company
  Future<Either<Failure, void>> joinCompany(String companyId);

  /// Get user by ID
  Future<Either<Failure, UserEntity>> getUserById(String userId);
}
