import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';

class DioHelper {
  static late Dio dio;
  static String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjkwYzg1M2M5YzA4YTdiZGE5MTk1OSIsImlhdCI6MTc4NTM1NTExMywiZXhwIjoxNzg3OTQ3MTEzfQ.oPLkqpqdQ9XKL5omWcubCZE2TdQ-DOqNi6AwDkCfIjY";
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
