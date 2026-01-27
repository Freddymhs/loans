import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenLocalDataSource {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<bool> hasToken();
}

class SharedPrefsTokenDataSource implements TokenLocalDataSource {
  SharedPrefsTokenDataSource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;
  static const String _tokenKey = 'auth_token';

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<void> deleteToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  @override
  Future<bool> hasToken() async {
    return sharedPreferences.containsKey(_tokenKey);
  }
}
