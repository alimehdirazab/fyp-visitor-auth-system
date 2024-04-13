import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
// import 'package:fyp/logic/services/visitor_preferences.dart';

class VisitorRepository {
  String? accessToken;
  Api _api;
  late Timer _tokenRefreshTimer; // Timer for periodic token refresh

  VisitorRepository() : _api = Api() {
    _getAccessToken();
  }

  Future _getAccessToken() async {
    // Fetch access token from SharedPreferences
    final preferences = await VisitorPreferences.fetchVisitorDetails();
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

      return VisitorData.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool> verifyEmail(
      {required int visitorId, required String verificationOTP}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/api/v1/visitors/verify-email',
        data: jsonEncode({
          "userId": visitorId,
          "verificationOTP": verificationOTP,
        }),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.data);
        bool emailVerified = responseData['data']['emailVerified'];
        return emailVerified;
      } else if (apiResponse.status == 400) {
        return false;
      } else {
        throw 'Failed to verify email: ${response.data}';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future resendOtp({required String email}) async {
    try {
      Response response = await _api.sendRequest.post(
        '/api/v1/visitors/resend-email-verification',
        data: jsonEncode({
          "email": email,
        }),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 200) {
        throw apiResponse.message.toString();
      }
      return apiResponse.status;
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> refreshTokens() async {
    // Retrieve refresh token
    final visitorData = await VisitorPreferences.fetchVisitorDetails();
    String? refreshToken = visitorData['refreshToken'];

    if (refreshToken != null) {
      try {
        // Send a request to refresh the tokens using the refresh token
        Response response = await _api.sendRequest.post(
          '/api/v1/visitors/refresh-token',
          data: {'refreshToken': refreshToken},
        );

        // Process the response and update tokens
        Map<String, dynamic> responseData = jsonDecode(response.data);
        String newAccessToken = responseData["accessToken"];
        String newRefreshToken = responseData["refreshToken"];
        String? email = visitorData["email"];
        String? password = visitorData["password"];
        String? visitorId = visitorData["id"];

        await VisitorPreferences.saveVisitorDetails(newAccessToken,
            newRefreshToken, email!, password!, visitorId!, true);
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
