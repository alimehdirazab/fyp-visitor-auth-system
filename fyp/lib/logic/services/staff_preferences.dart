import 'package:shared_preferences/shared_preferences.dart';

class StaffPreferences {
  static const String _accessTokenKey = "staff_accessToken";
  static const String _refreshTokenKey = "staff_refreshToken";
  static const String _emailKey = "staff_email";
  static const String _passwordKey = "staff_password";
  static const String _roleKey = "staff_role";
  static const String _staffIdKey = "staff_staffId";
  static const String _nameKey = "staff_name";
  static const String _profilePicKey = "staff_profilePic";
  static const String _cnicFrontPicKey = "staff_cnicFrontPic";
  static const String _cnicBackPicKey = "staff_cnicBackPic";

  static Future<void> saveStaffDetails(
    String staffId,
    String name,
    String profilePic,
    String cnicFrontPic,
    String cnicBackPic,
    String email,
    String role,
    String accessToken,
    String refreshToken,
    String password,
  ) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(_staffIdKey, staffId);
    await instance.setString(_nameKey, name);
    await instance.setString(_profilePicKey, profilePic);
    await instance.setString(_cnicFrontPicKey, cnicFrontPic);
    await instance.setString(_cnicBackPicKey, cnicBackPic);
    await instance.setString(_emailKey, email);
    await instance.setString(_roleKey, role);
    await instance.setString(_accessTokenKey, accessToken);
    await instance.setString(_refreshTokenKey, refreshToken);
    await instance.setString(_passwordKey, password);
  }

  static Future<Map<String, dynamic>> fetchStaffDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? staffId = instance.getString(_staffIdKey);
    String? name = instance.getString(_nameKey);
    String? profilePic = instance.getString(_profilePicKey);
    String? cnicFrontPic = instance.getString(_cnicFrontPicKey);
    String? cnicBackPic = instance.getString(_cnicBackPicKey);
    String? email = instance.getString(_emailKey);
    String? role = instance.getString(_roleKey);
    String? accessToken = instance.getString(_accessTokenKey);
    String? refreshToken = instance.getString(_refreshTokenKey);
    String? password = instance.getString(_passwordKey);

    return {
      "staffId": staffId,
      "name": name,
      "profilePic": profilePic,
      "cnicFrontPic": cnicFrontPic,
      "cnicBackPic": cnicBackPic,
      "email": email,
      "role": role,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "password": password,
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(_staffIdKey);
    await instance.remove(_nameKey);
    await instance.remove(_profilePicKey);
    await instance.remove(_cnicFrontPicKey);
    await instance.remove(_cnicBackPicKey);
    await instance.remove(_emailKey);
    await instance.remove(_roleKey);
    await instance.remove(_accessTokenKey);
    await instance.remove(_refreshTokenKey);
    await instance.remove(_passwordKey);
  }
}
