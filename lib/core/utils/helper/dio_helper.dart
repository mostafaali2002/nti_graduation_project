import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';

class DioHelper {
  static late Dio dio;
  static String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjNjN2I3ZmY4Yzk4YjE2NzcyOTk2YSIsImlhdCI6MTc4NDkyNDEzOSwiZXhwIjoxNzg3NTE2MTM5fQ.KU7CP8RSbNjzEttsOTBdXP1LyCin3iYjo8-EKZe0jZw";
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioExceptionType.badResponse:
        if (error.response?.data is Map<String, dynamic>) {
          return error.response?.data['message'] ??
              'Server error with status code: ${error.response?.statusCode}';
        }
        return 'Server error with status code: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
