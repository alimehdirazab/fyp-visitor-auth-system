import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fyp/core/api.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/staff/staff_details_model.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';
import 'package:fyp/data/models/visitor/visitor_update_details_model.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
import 'package:fyp/main.dart';
import 'package:path/path.dart';
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
      String? fcmToken = AppConfig.fcmToken;

      Response response = await _api.sendRequest.post(
        '/api/v1/visitors/signup',
        data: jsonEncode({
          "email": email,
          "password": password,
          "fcmToken": fcmToken,
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
      String? fcmToken = AppConfig.fcmToken;

      Response response = await _api.sendRequest.post(
        '/api/v1/visitors/login',
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

      return VisitorData.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool> verifyEmail(
      {required String visitorId, required String verificationOTP}) async {
    try {
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];
      Response response = await _api.sendRequest.post(
        '/api/v1/visitors/verify-email',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode({
          "userId": visitorId,
          "verificationOTP": verificationOTP,
        }),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status == 200) {
        Map<String, dynamic> responseData = apiResponse.data;

        bool emailVerified = responseData['emailVerified'];

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
        String? phoneNumber = visitorData["phone"];
        String? visitorName = visitorData["name"];
        String? profilePicture = visitorData["profilePic"];
        String? cnicBackPicture = visitorData["cnicBacPic"];
        String? cnicFrontPicture = visitorData["cnicFrontPic"];

        await VisitorPreferences.saveVisitorDetails(
            newAccessToken,
            newRefreshToken,
            email!,
            password!,
            visitorId!,
            true,
            phoneNumber!,
            visitorName!,
            profilePicture!,
            cnicBackPicture!,
            cnicFrontPicture!);
      } catch (error) {
        // Handle error when refreshing tokens
        print("Error refreshing tokens: $error");
      }
    } else {
      // Handle case where refresh token is not available
      print("Refresh token not found.");
    }
  }

  Future<List<StaffDetailsData>> fetchStaffDetails() async {
    try {
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];

      final response = await _api.sendRequest.get(
        '/api/v1/users',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // Check if the response status is 200
      if (apiResponse.status == 200) {
        // Parse the response JSON into StaffDetailsModel
        List<dynamic> responseData = apiResponse.data;
        List<StaffDetailsData> staffDetailsList = responseData
            .map((data) => StaffDetailsData.fromJson(data))
            .toList();

        // Return the list of StaffData from the model
        return staffDetailsList;
      } else {
        // If the response status is not 200, throw an error
        throw ('Error fetching staff details: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any error that occurred during the process
      throw ('Error fetching staff details: $e');
    }
  }

  Future<String> uploadFile({
    required String fileName,
    required String filePath,
  }) async {
    try {
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];

      // Read the file and encode it to base64
      final File file = File(filePath);
      final String base64String = base64Encode(file.readAsBytesSync());

      // Prepare the request payload
      final Map<String, dynamic> payload = {
        'fileName': fileName,
        'file': base64String,
      };

      // Make the HTTP POST request
      final response = await _api.sendRequest.post(
        '/api/v1/images/upload',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode(payload),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // Check the response status
      if (apiResponse.status != 200) {
        throw Exception('Upload failed');
      }

      // Decode the response body
      final Map<String, dynamic> data = apiResponse.data;

      return data['fileUrl']
          .toString(); // Assuming the response contains a 'url' field
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  Future<VisitorUpdateDetailsModel> updateVisitorDetails({
    required String name,
    required String phone,
    required String profilePic,
    required String cnicFrontPic,
    required String cnicBackPic,
  }) async {
    try {
      print('Updating visitor details: $name, $phone, $profilePic');

      // Fetch visitor details from SharedPreferences
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];
      final visitorId = preferences['visitorId'];

      // Prepare request data
      final requestData = {
        "name": name,
        "phone": phone,
        "profilePic": profilePic,
        "cnicFrontPic": cnicFrontPic,
        "cnicBacPic": cnicBackPic,
      };

      // Send PUT request to update visitor details
      final response = await _api.sendRequest.put(
        '/api/v1/visitors/$visitorId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode(requestData), // Encode request data to JSON
      );

      print('Response data: ${response.data}');

      // Handle response
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status == 200) {
        return VisitorUpdateDetailsModel.fromJson(apiResponse.data);
      } else {
        throw ('Error updating visitor details: ${apiResponse.status}');
      }
    } catch (e) {
      throw ('Failed to update details: $e');
    }
  }

  Future<AppointmentDataModel> createAppointment({
    required String staffId,
    required String date,
    required String time,
    required String purpose,
  }) async {
    try {
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];
      final visitorId = preferences['visitorId'];
      const title = 'Appointment';

      final response = await _api.sendRequest.post(
        '/api/v1/appointments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode({
          "scheduleTime": time,
          "scheduleDate": date,
          "title": title,
          "reason": purpose,
          "userId": staffId,
          "visitorId": visitorId,
        }),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status == 201) {
        return AppointmentDataModel.fromJson(apiResponse.data);
      } else {
        throw ('Error creating appointment: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Error creating appointment: $e');
    }
  }

  Future<List<AppointmentDataModel>> fetchAppointments() async {
    try {
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];
      final visitorId = preferences['visitorId'];

      final response = await _api.sendRequest.get(
        '/api/v1/appointments/visitor/$visitorId',
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
        // Check if responseData is a List
        if (apiResponse.data is List) {
          List<dynamic> responseData = apiResponse.data as List<dynamic>;

          // Convert the list of JSON objects into a list of AppointmentDataModel
          List<AppointmentDataModel> appointments = responseData
              .map((data) =>
                  AppointmentDataModel.fromJson(data as Map<String, dynamic>))
              .toList();

          return appointments;
        } else {
          throw Exception(
              'Expected a list of appointments but got ${apiResponse.data.runtimeType}');
        }
      } else {
        throw Exception('Error fetching appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointments: $e');
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
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];

      // Fetch the current appointment data to retrieve existing mapTrackings
      final appointmentResponse = await _api.sendRequest.get(
        '/api/v1/appointments/$appointmentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      ApiResponse appointmentApiResponse =
          ApiResponse.fromResponse(appointmentResponse);
      if (appointmentApiResponse.status != 200) {
        throw ('Error fetching appointment: ${appointmentApiResponse.message}');
      }

      // Parse the existing appointment data
      AppointmentDataModel currentAppointment =
          AppointmentDataModel.fromJson(appointmentApiResponse.data);

      // Get the existing mapTrackings and append the new tracking data
      List<dynamic> currentMapTrackings = currentAppointment.mapTrackings ?? [];

      currentMapTrackings.add({
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
      });

      // Update the appointment with the new mapTrackings array
      final data = {
        'mapTrackings': currentMapTrackings,
        'status': status,
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

      AppointmentDataModel updatedAppointment =
          AppointmentDataModel.fromJson(apiResponse.data);
      return updatedAppointment;
    } catch (e) {
      throw ('Error updating appointment: $e');
    }
  }

  Future<VisitorUpdateDetailsModel> updateVisitorIndividualDetail({
    String? name,
    String? phone,
    String? profilePic,
    String? cnicFrontPic,
    String? cnicBackPic,
    String? password,
  }) async {
    try {
      print('Updating visitor details: $name, $phone, $profilePic, $password');

      // Fetch visitor details from SharedPreferences
      final preferences = await VisitorPreferences.fetchVisitorDetails();
      final accessToken = preferences['accessToken'];
      final visitorId = preferences['visitorId'];

      // Prepare request data dynamically based on which fields are provided
      final Map<String, dynamic> requestData = {};

      if (name != null && name.isNotEmpty) requestData['name'] = name;
      if (phone != null && phone.isNotEmpty) requestData['phone'] = phone;
      if (profilePic != null && profilePic.isNotEmpty)
        requestData['profilePic'] = profilePic;
      if (cnicFrontPic != null && cnicFrontPic.isNotEmpty)
        requestData['cnicFrontPic'] = cnicFrontPic;
      if (cnicBackPic != null && cnicBackPic.isNotEmpty)
        requestData['cnicBackPic'] = cnicBackPic;
      if (password != null && password.isNotEmpty)
        requestData['password'] = password;

      if (requestData.isEmpty) {
        throw 'No fields provided for update'; // Optional: Throw an error if no fields are provided
      }

      // Send PUT request to update visitor details
      final response = await _api.sendRequest.put(
        '/api/v1/visitors/$visitorId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode(requestData), // Encode request data to JSON
      );

      print('Response data: ${response.data}');

      // Handle response
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status == 200) {
        return VisitorUpdateDetailsModel.fromJson(apiResponse.data);
      } else {
        throw ('Error updating visitor details: ${apiResponse.status}');
      }
    } catch (e) {
      throw ('Failed to update details: $e');
    }
  }

  // Method to cancel the token refresh timer when signing out
  void cancelTokenRefreshTimer() {
    _tokenRefreshTimer.cancel();
  }
}
