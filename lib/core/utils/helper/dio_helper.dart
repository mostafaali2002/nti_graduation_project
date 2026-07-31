import 'package:dio/dio.dart';
import 'package:nti_graduation_project/core/constant/api_constants.dart';

class DioHelper {
  static late Dio dio;
  static String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjlmMzhjM2IzY2U3OGFjZDA2YzYzZCIsImlhdCI6MTc4NTMyODU2OSwiZXhwIjoxNzg3OTIwNTY5fQ.77txw7z5r6UQUsWYwn88Ly_DisBM6CUnD585FGUqTao";
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          "Authorization": "Bearer ${DioHelper.token}",
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
      ),
    );
  }

  //
}
