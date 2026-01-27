import 'package:loans/0_data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> loginWithGoogle();

  Future<void> logOut();

  Future<UserModel> getCurrentUser();

  Future<bool> isSessionActive();
}
