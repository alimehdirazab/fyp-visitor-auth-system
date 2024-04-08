import 'package:shared_preferences/shared_preferences.dart';

class StaffPreferences {
  static const String _accessTokenKey = "accessToken";
  static const String _refreshTokenKey = "refreshToken";
  static const String _emailKey = "email";
  static const String _passwordKey = "password";
  static const String _roleKey = "role"; // Add role key

  static Future<void> saveStaffDetails(String accessToken, String refreshToken,
      String email, String password, String role) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(_accessTokenKey, accessToken);
    await instance.setString(_refreshTokenKey, refreshToken);
    await instance.setString(_emailKey, email);
    await instance.setString(_passwordKey, password);
    await instance.setString(_roleKey, role); // Save role
  }

  static Future<Map<String, String?>> fetchStaffDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? accessToken = instance.getString(_accessTokenKey);
    String? refreshToken = instance.getString(_refreshTokenKey);
    String? email = instance.getString(_emailKey);
    String? password = instance.getString(_passwordKey);
    String? role = instance.getString(_roleKey); // Fetch role
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "email": email,
      "password": password,
      "role": role, // Return role
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(_accessTokenKey);
    await instance.remove(_refreshTokenKey);
    await instance.remove(_emailKey);
    await instance.remove(_passwordKey);
    await instance.remove(_roleKey); // Clear role
  }
}
