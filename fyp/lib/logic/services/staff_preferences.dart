import 'package:shared_preferences/shared_preferences.dart';

class StaffPreferences {
  static Future<void> saveStaffDetails(String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);
    // await instance.setString("role", role);
  }

  static Future<Map<String, dynamic>> fetchStaffDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    String? role = instance.getString("role");
    //String? accessToken = instance.getString("accessToken");
    return {
      "email": email,
      "password": password,
      "role": role,
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}
