import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';

class VisitorRepository {
  final _api = Api();

  Future<VisitorModel> createAccount(
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
      // Preferences.saveTokens(accessToken, refreshToken);

      return VisitorModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<VisitorModel> signIn(
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
      // Preferences.saveTokens(accessToken, refreshToken);

      return VisitorModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
