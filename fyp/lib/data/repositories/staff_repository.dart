import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/staff/staff_model.dart';
import 'package:fyp/logic/services/staff_preferences.dart';

class StaffRepository {
  String? accessToken;
  Api _api;

  StaffRepository() : _api = Api() {
    _getAccessToken();
  }

  Future _getAccessToken() async {
    // Fetch access token from SharedPreferences
    final preferences = await StaffPreferences.fetchStaffDetails();
    accessToken = preferences['accessToken'];
    _api = Api(accessToken: accessToken);
  }

  Future<StaffModel> createAccount(
      {required String email,
      required String password,
      required String role}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/api/v1/users/signup',
        data: jsonEncode({
          "email": email,
          "password": password,
          "role": role,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 201) {
        throw apiResponse.message.toString();
      }

      // String accessToken = apiResponse.data["accessToken"];
      // String refreshToken = apiResponse.data["refreshToken"];
      // Preferences.saveTokens(accessToken, refreshToken);

      return StaffModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<StaffData> signIn(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/api/v1/users/login',
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
      // Preferences.saveTokens(accessToken, refreshToken);
      // log(apiResponse.data.toString());
      // StaffData stf = StaffData.fromJson(apiResponse.data);
      // log(stf.role.toString() + "dddd");
      return StaffData.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
