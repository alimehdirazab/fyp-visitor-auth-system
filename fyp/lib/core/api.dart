import 'package:dio/dio.dart';
import 'package:fyp/logic/services/preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String BASE_URL = "https://vms-backend-eight.vercel.app";
const Map<String, dynamic> DEFAULT_HEADERS = {
  'Content-Type': 'application/json',
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;

    _dio.options.connectTimeout = const Duration(seconds: 20); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 20); // 5 seconds

    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.uri}');
        print('Headers: ${options.headers}');
        print('Body: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.statusMessage}');
        print('Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print('Dio error: $e');
        return handler.next(e);
      },
    ));
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;
  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
      success: response.statusCode == 201,
      data: data["data"],
      message: data["message"] ?? "Unexpected error",
    );
  }
}
