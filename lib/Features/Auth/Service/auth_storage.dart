import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String tokenKey = 'token';
  static const String userIdKey = 'userId';
  static const String userNameKey = 'userName';
  static const String userEmailKey = 'userEmail';

  Future<void> saveSession({
    required String token,
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, token);
    await prefs.setString(userIdKey, userId);
    await prefs.setString(userNameKey, userName);
    await prefs.setString(userEmailKey, userEmail);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(tokenKey);
    await prefs.remove(userIdKey);
    await prefs.remove(userNameKey);
    await prefs.remove(userEmailKey);
  }

  Future<Map<String, String>?> getSession() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(tokenKey);
    final userId = prefs.getString(userIdKey);
    final userName = prefs.getString(userNameKey);
    final userEmail = prefs.getString(userEmailKey);

    if (token == null ||
        userId == null ||
        userName == null ||
        userEmail == null) {
      return null;
    }

    return {
      'token': token,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }
}
