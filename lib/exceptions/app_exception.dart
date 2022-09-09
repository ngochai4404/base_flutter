class AppException implements Exception {
  String title;
  String message;

  AppException(this.title, this.message);

  @override
  String toString() => '$title $message';
}

class CommonException extends AppException {
  CommonException() : super("Error", "Something went wrong");
}

class NoNetworkException extends AppException {
  NoNetworkException() : super("Error", "Error network");
}

class ExpiredException extends AppException {
  ExpiredException() : super("Error", "Account is expired");
}

class UnauthorizedException extends AppException {
  UnauthorizedException() : super("Error", "Unauthorized");
}


