import 'package:shared_preferences/shared_preferences.dart';

class VisitorPreferences {
  static const String _accessTokenKey = "visitor_accessToken";
  static const String _refreshTokenKey = "visitor_refreshToken";
  static const String _emailKey = "visitor_email";
  static const String _passwordKey = "visitor_password";
  static const String _visitorIdKey = "visitor_visitorId";
  static const String _emailVerifiedKey = "visitor_emailVerified";
  static const String _phoneNumberKey = "visitor_phoneNumber";
  static const String _visitorNameKey = "visitor_visitorName";
  static const String _profilePictureKey = "visitor_profilePicture";
  static const String _cnicBackPictureKey = "visitor_cnicBackPicture";
  static const String _cnicFrontPictureKey = "visitor_cnicFrontPicture";

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
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(_accessTokenKey, accessToken);
    await instance.setString(_refreshTokenKey, refreshToken);
    await instance.setString(_emailKey, email);
    await instance.setString(_passwordKey, password);
    await instance.setString(_visitorIdKey, visitorId);
    await instance.setBool(_emailVerifiedKey, emailVerified);
    await instance.setString(_phoneNumberKey, phoneNumber);
    await instance.setString(_visitorNameKey, visitorName);
    await instance.setString(_profilePictureKey, profilePicture);
    await instance.setString(_cnicBackPictureKey, cnicBackPicture);
    await instance.setString(_cnicFrontPictureKey, cnicFrontPicture);
  }

  static Future<Map<String, dynamic>> fetchVisitorDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? accessToken = instance.getString(_accessTokenKey);
    String? refreshToken = instance.getString(_refreshTokenKey);
    String? email = instance.getString(_emailKey);
    String? password = instance.getString(_passwordKey);
    String? visitorId = instance.getString(_visitorIdKey);
    bool? emailVerified = instance.getBool(_emailVerifiedKey);
    String? phoneNumber = instance.getString(_phoneNumberKey);
    String? visitorName = instance.getString(_visitorNameKey);
    String? profilePicture = instance.getString(_profilePictureKey);
    String? cnicBackPicture = instance.getString(_cnicBackPictureKey);
    String? cnicFrontPicture = instance.getString(_cnicFrontPictureKey);

    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "email": email,
      "password": password,
      "visitorId": visitorId,
      "emailVerified": emailVerified,
      "phoneNumber": phoneNumber,
      "visitorName": visitorName,
      "profilePicture": profilePicture,
      "cnicBackPicture": cnicBackPicture,
      "cnicFrontPicture": cnicFrontPicture,
    };
  }

  static Future<void> updateVisitorDetails({
    String? accessToken,
    String? refreshToken,
    String? email,
    String? password,
    String? visitorId,
    bool? emailVerified,
    String? phoneNumber,
    String? visitorName,
    String? profilePicture,
    String? cnicBackPicture,
    String? cnicFrontPicture,
  }) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (accessToken != null)
      await instance.setString(_accessTokenKey, accessToken);
    if (refreshToken != null)
      await instance.setString(_refreshTokenKey, refreshToken);
    if (email != null) await instance.setString(_emailKey, email);
    if (password != null) await instance.setString(_passwordKey, password);
    if (visitorId != null) await instance.setString(_visitorIdKey, visitorId);
    if (emailVerified != null)
      await instance.setBool(_emailVerifiedKey, emailVerified);
    if (phoneNumber != null)
      await instance.setString(_phoneNumberKey, phoneNumber);
    if (visitorName != null)
      await instance.setString(_visitorNameKey, visitorName);
    if (profilePicture != null)
      await instance.setString(_profilePictureKey, profilePicture);
    if (cnicBackPicture != null)
      await instance.setString(_cnicBackPictureKey, cnicBackPicture);
    if (cnicFrontPicture != null)
      await instance.setString(_cnicFrontPictureKey, cnicFrontPicture);
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(_accessTokenKey);
    await instance.remove(_refreshTokenKey);
    await instance.remove(_emailKey);
    await instance.remove(_passwordKey);
    await instance.remove(_visitorIdKey);
    await instance.remove(_emailVerifiedKey);
    await instance.remove(_phoneNumberKey);
    await instance.remove(_visitorNameKey);
    await instance.remove(_profilePictureKey);
    await instance.remove(_cnicBackPictureKey);
    await instance.remove(_cnicFrontPictureKey);
  }
}
