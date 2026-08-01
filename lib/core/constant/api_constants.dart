abstract class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1';
  static const String categoriesEndPoint = '/home/categories';
  static const String allProductEndPoint =
      '$baseUrl/home/products?skip=0&limit=10';
  static const String getCartEndPoint = '$baseUrl/user/getCart';
  static const String addCartEndPoint = '$baseUrl/user/addCart';
  static const String deleteCartEndPoint = '$baseUrl/user/deleteCart';
  static const String searchEndPoint = '$baseUrl/home/productsFilter';
  static const String register = '$baseUrl/auth/signUp';
  static const String login = '$baseUrl/auth/signIn';
  static const String accountEndPointGet = '$baseUrl/portfoilo/userData';
  static const String accountEndPointPost = '$baseUrl/portfoilo/editUserData';

  static const String addToFavourite = "/user/addFavorite";
  static const String getFavourite = "/user/getFavorite";

  static const String deleteFavourite = "/user/deleteFavorite";

  static String productsByCategoryEndPoint(String slug) =>
      '$baseUrl/home/products/category/$slug';

}