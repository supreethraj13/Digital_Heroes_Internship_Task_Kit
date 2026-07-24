class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException()
      : super('No internet connection. Orders will refresh when you are back online.');
}
