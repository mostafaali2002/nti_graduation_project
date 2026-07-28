import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';

class DioHelper {
  static late Dio dio;
  static String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjkwYzg1M2M5YzA4YTdiZGE5MTk1OSIsImlhdCI6MTc4NTI2OTQwMCwiZXhwIjoxNzg3ODYxNDAwfQ.4YBfUnv6Mrfh-vX7Dlq2rTecX0MC44xmeli-3XAzG-Y";
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
