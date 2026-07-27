abstract class ApiConstant {
  static const String baseUrl = 'https://supermarket-dan1.onrender.com/api/v1';
  static const String categoriesEndPoint = '/home/categories';
  static const String allProductEndPoint =
      '$baseUrl/home/products?skip=0&limit=10';
  static const String register = '$baseUrl/auth/signUp';
    
static const String addToFavourite="/user/addFavorite";
static const String getFavourite="/user/getFavorite";

static const String deleteFavourite="/user/deleteFavorite";




}
