import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
// import 'package:fyp/logic/services/visitor_preferences.dart';

class VisitorRepository {
  String? accessToken;
  Api _api;

  VisitorRepository() : _api = Api() {
    _getAccessToken();
  }

  Future _getAccessToken() async {
    // Fetch access token from SharedPreferences
    final preferences = await VisitorPreferences.fetchVisitorDetails();
    accessToken = preferences['accessToken'];
    _api = Api(accessToken: accessToken);
  }

  Future<VisitorData> createAccount(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/api/v1/visitors/signup',
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 201) {
        throw apiResponse.message.toString();
      }

      // String accessToken = apiResponse.data["accessToken"];
      // String refreshToken = apiResponse.data["refreshToken"];

      // // Save tokens
      // await VisitorPreferences.saveVisitorDetails(accessToken, refreshToken);

      return VisitorData.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<VisitorData> signIn(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/api/v1/visitors/login',
        options: Options(
          validateStatus: (status) => true,
          followRedirects: false,
        ),
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 200) {
        throw apiResponse.message.toString();
      }

      // String accessToken = apiResponse.data["accessToken"];
      // String refreshToken = apiResponse.data["refreshToken"];

      // // Save tokens
      // await VisitorPreferences.saveVisitorDetails(accessToken, refreshToken);

      return VisitorData.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
