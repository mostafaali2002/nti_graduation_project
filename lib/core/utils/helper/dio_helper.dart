import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';

class DioHelper {
  static late Dio dio;
  static String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjg3NjEyYzdmZjY2NWQzOTY2MmQ5OSIsImlhdCI6MTc4NTMxMjkxOCwiZXhwIjoxNzg3OTA0OTE4fQ.nmffHpfcL9cEC2caU4EC4tqh8iAryIGzA5A75YQfRbo";
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
}
