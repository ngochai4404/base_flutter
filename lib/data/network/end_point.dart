
class EndPoint {
  EndPoint._();

  // base url
  static const String baseUrl = "http://45.76.160.15:8080/";
  // static const String baseUrl = "http://localhost:8080/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String login = '/api/login';
  static const String user = '/api/user';
}