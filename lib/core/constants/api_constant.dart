class ApiConstant {
  /// Base URL for API endpoints
  static const String baseUrl = 'https://api.example.com';

  /// API endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String getProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String getProducts = '/products';
  static const String getProductDetails = '/products/:id';
  static const String addToCart = '/cart/add';
  static const String removeFromCart = '/cart/remove';
  static const String getCart = '/cart';
  static const String checkout = '/checkout';
  static const String getOrders = '/orders';
  static const String getOrderDetails = '/orders/:id';

  /// Timeout duration in seconds
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  /// Headers
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}

