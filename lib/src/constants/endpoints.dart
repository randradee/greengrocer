const String baseUrl = 'https://parseapi.back4app.com/functions/';

abstract class Endpoints {
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String changePassword = '$baseUrl/change-password';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getCategoryList = '$baseUrl/get-category-list';
  static const String getProductList = '$baseUrl/get-product-list';
}
