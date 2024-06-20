import 'package:shared_preferences/shared_preferences.dart';

class VisitorPreferences {
  static const String _accessTokenKey = "accessToken";
  static const String _refreshTokenKey = "refreshToken";
  static const String _emailKey = "email"; // Add email key
  static const String _passwordKey = "password"; // Add password key
  static const String _visitorIdKey = "visitorId"; // Add visitorId key
  static const String _emailVerifiedKey =
      "emailVerified"; // Add emailVerified key
  static const String _phoneNumberKey = "phoneNumber"; // Add phoneNumber key
  static const String _visitorNameKey = "visitorName"; // Add visitorName key
  static const String _profilePictureKey =
      "profilePicture"; // Add profilePicture key
  static const String _cnicBackPictureKey =
      "cnicBackPicture"; // Add cnicBackPicture key
  static const String _cnicFrontPictureKey =
      "cnicFrontPicture"; // Add cnicFrontPicture key

  static Future<void> saveVisitorDetails(
      String accessToken,
      String refreshToken,
      String email,
      String password,
      String visitorId,
      bool emailVerified,
      String phoneNumber,
      String visitorName,
      String profilePicture,
      String cnicBackPicture,
      String cnicFrontPicture) async {
    // Add email, password, visitorId, and emailVerified parameters
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(_accessTokenKey, accessToken);
    await instance.setString(_refreshTokenKey, refreshToken);
    await instance.setString(_emailKey, email); // Save email
    await instance.setString(_passwordKey, password); // Save password
    await instance.setString(_visitorIdKey, visitorId); // Save visitorId
    await instance.setBool(
        _emailVerifiedKey, emailVerified); // Save emailVerified
    await instance.setString(_phoneNumberKey, phoneNumber); // Save phoneNumber
    await instance.setString(_visitorNameKey, visitorName); // Save visitorName
    await instance.setString(
        _profilePictureKey, profilePicture); // Save profilePicture
    await instance.setString(
        _cnicBackPictureKey, cnicBackPicture); // Save cnicBackPicture
    await instance.setString(
        _cnicFrontPictureKey, cnicFrontPicture); // Save cnicFrontPicture
  }

  static Future<Map<String, dynamic>> fetchVisitorDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? accessToken = instance.getString(_accessTokenKey);
    String? refreshToken = instance.getString(_refreshTokenKey);
    String? email = instance.getString(_emailKey); // Fetch email
    String? password = instance.getString(_passwordKey); // Fetch password
    String? visitorId = instance.getString(_visitorIdKey); // Fetch visitorId
    bool? emailVerified =
        instance.getBool(_emailVerifiedKey); // Fetch emailVerified
    String? phoneNumber =
        instance.getString(_phoneNumberKey); // Fetch phoneNumber
    String? visitorName =
        instance.getString(_visitorNameKey); // Fetch visitorName
    String? profilePicture =
        instance.getString(_profilePictureKey); // Fetch profilePicture
    String? cnicBackPicture =
        instance.getString(_cnicBackPictureKey); // Fetch cnicBackPicture
    String? cnicFrontPicture =
        instance.getString(_cnicFrontPictureKey); // Fetch cnicFrontPicture

    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "email": email, // Return email
      "password": password, // Return password
      "visitorId": visitorId, // Return visitorId
      "emailVerified": emailVerified, // Return emailVerified
      "phoneNumber": phoneNumber, // Return phoneNumber
      "visitorName": visitorName, // Return visitorName
      "profilePicture": profilePicture, // Return profilePicture
      "cnicBackPicture": cnicBackPicture, // Return cnicBackPicture
      "cnicFrontPicture": cnicFrontPicture, // Return cnicFrontPicture
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(_accessTokenKey);
    await instance.remove(_refreshTokenKey);
    await instance.remove(_emailKey); // Clear email
    await instance.remove(_passwordKey); // Clear password
    await instance.remove(_visitorIdKey); // Clear visitorId
    await instance.remove(_emailVerifiedKey); // Clear emailVerified
  }
}
