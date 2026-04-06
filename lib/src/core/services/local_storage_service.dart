import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _preferences;

  LocalStorageService(this._preferences);

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userRoleKey = 'user_role';

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    await _preferences.setString(_accessTokenKey, token);
  }

  /// Get access token
  String? getAccessToken() {
    return _preferences.getString(_accessTokenKey);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _preferences.setString(_refreshTokenKey, token);
  }

  /// Get refresh token
  String? getRefreshToken() {
    return _preferences.getString(_refreshTokenKey);
  }

  /// Clear all stored auth data
  Future<void> clearAuthData() async {
    await _preferences.remove(_accessTokenKey);
    await _preferences.remove(_refreshTokenKey);
    await _preferences.remove(_userRoleKey);
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return getAccessToken() != null;
  }
}
