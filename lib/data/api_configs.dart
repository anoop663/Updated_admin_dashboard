class ApiConfig {
  
  static const String _baseUrl = 'https://swan.alisonsnewdemo.online';
  static const String apiUrl = '$_baseUrl/api/';
  static const String bannerImageUrl = '$_baseUrl/images/banner/';
  static const String productImageUrl = '$_baseUrl/images/product/';
  static const String productThumbImageUrl ='$_baseUrl/images/product/thumbnail/';
  static const String brandImageUrl = '$_baseUrl/images/manufacturer/';
  static const String categoryImageUrl = '$_baseUrl/images/category/';
  static const String contentImageUrl = '$_baseUrl/images/content/';

  static int userAdCount = 0;
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  static const Map<String, String> headersMultipart = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
}
