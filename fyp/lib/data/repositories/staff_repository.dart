import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/staff/staff_model.dart';
import 'package:fyp/logic/services/staff_preferences.dart';

class StaffRepository {
  String? accessToken;
  Api _api;
  late Timer _tokenRefreshTimer; // Timer for periodic token refresh

  StaffRepository() : _api = Api() {
    _getAccessToken();
  }

  Future _getAccessToken() async {
    // Fetch access token from SharedPreferences
    final preferences = await StaffPreferences.fetchStaffDetails();
    accessToken = preferences['accessToken'];
    _api = Api(accessToken: accessToken);

    // Start the timer for periodic token refresh
    _startTokenRefreshTimer();
  }

  // Start a periodic timer to refresh the tokens every 20 hours
  void _startTokenRefreshTimer() {
    const refreshInterval = Duration(hours: 20);
    _tokenRefreshTimer = Timer.periodic(refreshInterval, (timer) {
      // Refresh tokens
      refreshTokens();
    });
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

  Future<void> refreshTokens() async {
    // Retrieve refresh token
    final staffData = await StaffPreferences.fetchStaffDetails();
    String? refreshToken = staffData['refreshToken'];

    if (refreshToken != null) {
      try {
        // Send a request to refresh the tokens using the refresh token
        Response response = await _api.sendRequest.post(
          '/api/v1/users/refresh-token',
          data: {'refreshToken': refreshToken},
        );

        // Process the response and update tokens
        Map<String, dynamic> responseData = jsonDecode(response.data);
        String newAccessToken = responseData["accessToken"];
        String newRefreshToken = responseData["refreshToken"];
        String? email = staffData["email"];
        String? password = staffData["password"];
        String? role = staffData["role"];
        await StaffPreferences.saveStaffDetails(
            newAccessToken, newRefreshToken, email!, password!, role!);
      } catch (error) {
        // Handle error when refreshing tokens
        print("Error refreshing tokens: $error");
      }
    } else {
      // Handle case where refresh token is not available
      print("Refresh token not found.");
    }
  }

  // Method to cancel the token refresh timer when signing out
  void cancelTokenRefreshTimer() {
    _tokenRefreshTimer.cancel();
  }
}
