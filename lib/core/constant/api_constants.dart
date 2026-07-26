abstract class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1';
  static const String categoriesEndPoint = '$baseUrl/home/categories';
  static const String allProductEndPoint =
      '$baseUrl/home/products?skip=0&limit=10';
}
