import 'package:shared_preferences/shared_preferences.dart';

class VisitorPreferences {
  static const String _accessTokenKey = "accessToken";
  static const String _refreshTokenKey = "refreshToken";
  static const String _emailKey = "email"; // Add email key
  static const String _passwordKey = "password"; // Add password key
  static const String _visitorIdKey = "visitorId"; // Add visitorId key

  static Future<void> saveVisitorDetails(
      String accessToken,
      String refreshToken,
      String email,
      String password,
      String visitorId) async {
    // Add email, password, and visitorId parameters
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(_accessTokenKey, accessToken);
    await instance.setString(_refreshTokenKey, refreshToken);
    await instance.setString(_emailKey, email); // Save email
    await instance.setString(_passwordKey, password); // Save password
    await instance.setString(_visitorIdKey, visitorId); // Save visitorId
  }

  static Future<Map<String, String?>> fetchVisitorDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? accessToken = instance.getString(_accessTokenKey);
    String? refreshToken = instance.getString(_refreshTokenKey);
    String? email = instance.getString(_emailKey); // Fetch email
    String? password = instance.getString(_passwordKey); // Fetch password
    String? visitorId = instance.getString(_visitorIdKey); // Fetch visitorId
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "email": email, // Return email
      "password": password, // Return password
      "visitorId": visitorId, // Return visitorId
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(_accessTokenKey);
    await instance.remove(_refreshTokenKey);
    await instance.remove(_emailKey); // Clear email
    await instance.remove(_passwordKey); // Clear password
    await instance.remove(_visitorIdKey); // Clear visitorId
  }
}
