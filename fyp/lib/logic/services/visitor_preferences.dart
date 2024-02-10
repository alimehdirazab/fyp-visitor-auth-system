import 'package:shared_preferences/shared_preferences.dart';

class VisitorPreferences {
  static Future<void> saveVisitorDetails(String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);
  }

  static Future<Map<String, dynamic>> fetchVisitorDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    String? accessToken = instance.getString("accessToken");
    return {
      "email": email,
      "password": password,
      "accessToken": accessToken,
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}
