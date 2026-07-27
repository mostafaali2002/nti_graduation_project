import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';

class DioHelper {
  static late Dio dio;
  static String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjFlMDJhYzJjM2VjYTMwZTdhNDRjYiIsImlhdCI6MTc4NTA4MDE4MSwiZXhwIjoxNzg3NjcyMTgxfQ.ReeSk-MDG-gaBxOJ1-05v9dX_Gpix6CkgJFtg5bH3Ac";
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
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
