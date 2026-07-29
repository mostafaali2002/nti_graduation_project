abstract class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1';
  static const String categoriesEndPoint = '$baseUrl/home/categories';
  static const String allProductEndPoint =
      '$baseUrl/home/products?skip=0&limit=10';
  static const String register = '$baseUrl/auth/signUp';
  static const String login = '$baseUrl/auth/signIn';
  static const String accountEndPointGet = '$baseUrl/portfoilo/userData';
  static const String accountEndPointPost = '$baseUrl/portfoilo/editUserData';
}
