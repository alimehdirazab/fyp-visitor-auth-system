import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/staff/staff_model.dart';
import 'package:fyp/logic/services/staff_preferences.dart';
import 'package:fyp/main.dart';

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
      String? fcmToken = AppConfig.fcmToken;

      Response response = await _api.sendRequest.post(
        '/api/v1/users/signup',
        data: jsonEncode({
          "email": email,
          "password": password,
          "role": role,
          "fcmToken": fcmToken,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 201) {
        throw apiResponse.message.toString();
      }

      return StaffModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<StaffData> signIn(
      {required String email, required String password}) async {
    try {
      String? fcmToken = AppConfig.fcmToken;

      Response response = await _api.sendRequest.post(
        '/api/v1/users/login',
        options: Options(
          validateStatus: (status) => true,
          followRedirects: false,
        ),
        data: jsonEncode({
          "email": email,
          "password": password,
          "fcmToken": fcmToken,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 200) {
        throw apiResponse.message.toString();
      }

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
        String? staffId = staffData["id"];
        String? name = staffData["name"];
        String? profilePic = staffData["profilePic"];
        String? cnicFrontPic = staffData["cnicFrontPic"];
        String? cnicBackPic = staffData["cnicBacPic"];
        await StaffPreferences.saveStaffDetails(
          newAccessToken,
          newRefreshToken,
          email!,
          password!,
          role!,
          staffId!,
          name!,
          profilePic!,
          cnicFrontPic!,
          cnicBackPic!,
        );
      } catch (error) {
        // Handle error when refreshing tokens
        print("Error refreshing tokens: $error");
      }
    } else {
      // Handle case where refresh token is not available
      print("Refresh token not found.");
    }
  }

  Future<List<AppointmentDataModel>> fetchAppointments() async {
    try {
      final preferences = await StaffPreferences.fetchStaffDetails();
      final accessToken = preferences['accessToken'];
      final staffId = preferences['staffId'];

      final response = await _api.sendRequest.get(
        '/api/v1/appointments/user/$staffId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (apiResponse.status == 200) {
        // Directly handle the list of appointments from the response data
        List<dynamic> responseData = apiResponse.data as List<dynamic>;
        List<AppointmentDataModel> appointments = responseData
            .map((data) =>
                AppointmentDataModel.fromJson(data as Map<String, dynamic>))
            .toList();
        return appointments;
      } else {
        throw ('Error fetching appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Error fetching appointments: $e');
    }
  }

  Future<List<AppointmentDataModel>> fetchAllAppointments() async {
    try {
      final preferences = await StaffPreferences.fetchStaffDetails();
      final accessToken = preferences['accessToken'];

      final response = await _api.sendRequest.get(
        '/api/v1/appointments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (apiResponse.status == 200) {
        // Directly handle the list of appointments from the response data
        List<dynamic> responseData = apiResponse.data as List<dynamic>;
        List<AppointmentDataModel> appointments = responseData
            .map((data) =>
                AppointmentDataModel.fromJson(data as Map<String, dynamic>))
            .toList();
        return appointments;
      } else {
        throw ('Error fetching appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Error fetching appointments: $e');
    }
  }

  Future<void> updateAppointment({
    required String appointmentId,
    DateTime? scheduleDate,
    DateTime? scheduleTime,
    String? status,
  }) async {
    try {
      final preferences = await StaffPreferences.fetchStaffDetails();
      final accessToken = preferences['accessToken'];

      final data = {
        if (scheduleDate != null)
          'scheduleDate': scheduleDate.toIso8601String(),
        if (scheduleTime != null)
          'scheduleTime': scheduleTime.toIso8601String(),
        if (status != null) 'status': status,
      };

      final response = await _api.sendRequest.put(
        '/api/v1/appointments/$appointmentId',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 200) {
        throw ('Error updating appointment: ${apiResponse.message}');
      }
    } catch (e) {
      throw ('Error updating appointment: $e');
    }
  }

  Future<Map<String, dynamic>> verifyQRCode(String qrToken) async {
    try {
      final preferences = await StaffPreferences.fetchStaffDetails();
      final accessToken = preferences['accessToken'];
      final userId = preferences['staffId'];

      final response = await _api.sendRequest.post(
        '/api/v1/users/verify-qrcode',
        data: {
          'qrToken': qrToken,
          'userId': userId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      throw Exception('Failed to verify QR Code: ${e.response?.data}');
    }
  }

  Future<AppointmentDataModel> getAppointmentVisitorLocation(
      String appointmentId) async {
    try {
      final preferences = await StaffPreferences.fetchStaffDetails();
      final accessToken = preferences['accessToken'];

      final response = await _api.sendRequest.get(
        '/api/v1/appointments/$appointmentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status == 200) {
        // Directly handle the appointment details from the response data
        AppointmentDataModel appointment =
            AppointmentDataModel.fromJson(apiResponse.data);
        return appointment;
      }
      throw Exception(
          'Failed to fetch Appointment Location: ${apiResponse.message}');
    } on DioError catch (e) {
      throw Exception(
          'Failed to fetch Appointment Location: ${e.response?.data}');
    }
  }

  Future<AppointmentDataModel> sendAppointmentLocation({
    required String appointmentId,
    double? latitude,
    double? longitude,
    int? timestamp,
    String? status,
  }) async {
    try {
      final preferences = await StaffPreferences.fetchStaffDetails();
      final accessToken = preferences['accessToken'];

      final data = {};

      final response = await _api.sendRequest.put(
        '/api/v1/appointments/$appointmentId',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status != 200) {
        throw ('Error updating appointment: ${apiResponse.message}');
      }
      AppointmentDataModel appointment =
          AppointmentDataModel.fromJson(apiResponse.data);
      return appointment;
    } catch (e) {
      throw ('Error updating appointment: $e');
    }
  }

  // Method to cancel the token refresh timer when signing out
  void cancelTokenRefreshTimer() {
    _tokenRefreshTimer.cancel();
  }
}
