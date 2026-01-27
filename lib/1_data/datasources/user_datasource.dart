import 'package:loans/1_data/models/company_model.dart';
import 'package:loans/1_data/models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> createUserOnboarding(UserModel user);

  Future<bool> isRootIdAvailable(String rootId);

  Future<CompanyModel> createCompany(CompanyModel company);

  Future<CompanyModel> getCompanyByName(String name);

  Future<void> joinCompany(String companyId);

  Future<UserModel> getUserById(String userId);
}
