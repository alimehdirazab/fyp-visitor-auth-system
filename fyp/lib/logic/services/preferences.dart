import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("accessToken", accessToken);
    await instance.setString("refreshToken", refreshToken);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString("accessToken");
  }

  // Other preferences methods...
}
