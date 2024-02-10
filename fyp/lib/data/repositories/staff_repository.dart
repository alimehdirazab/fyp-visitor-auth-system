import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/staff/staff_model.dart';

class StaffRepository {
  final _api = Api();

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

  Future<StaffModel> signIn(
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
      StaffModel stf = StaffModel.fromJson(apiResponse.data);
      log(stf.data.toString() + "dddd");
      return StaffModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
