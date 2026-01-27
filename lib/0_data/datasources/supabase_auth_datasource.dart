import 'package:loans/0_data/datasources/auth_datasource.dart';
import 'package:loans/0_data/models/user_model.dart';
import 'package:loans/3_utils/errors/exceptions.dart' as app_exceptions;
import 'package:supabase_flutter/supabase_flutter.dart';

typedef AuthOperation<T> = Future<T> Function();

class SupabaseAuthDataSource implements AuthDataSource {
  SupabaseAuthDataSource({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  Future<T> _handleAuthErrors<T>(AuthOperation<T> operation) async {
    try {
      return await operation();
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      throw app_exceptions.AuthException(message: message);
    }
  }

  UserModel _buildUserModel(User? user, String errorMessage) {
    if (user == null) {
      throw Exception(errorMessage);
    }
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['full_name'] as String? ?? '',
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.parse(user.createdAt),
    );
  }

  @override
  Future<UserModel> loginWithGoogle() {
    return _handleAuthErrors(() async {
      await supabaseClient.auth.signInWithOAuth(OAuthProvider.google);
      return _buildUserModel(
        supabaseClient.auth.currentUser,
        'Problema al iniciar sesión',
      );
    });
  }

  @override
  Future<void> logOut() {
    return _handleAuthErrors(() {
      return supabaseClient.auth.signOut();
    });
  }

  @override
  Future<UserModel> getCurrentUser() {
    return _handleAuthErrors(() async {
      return _buildUserModel(
        supabaseClient.auth.currentUser,
        'No user logged in',
      );
    });
  }

  @override
  Future<bool> isSessionActive() {
    return _handleAuthErrors(() async {
      return supabaseClient.auth.currentSession != null;
    });
  }
}
