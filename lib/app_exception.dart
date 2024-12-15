class AppException implements Exception {
  final String message;

  AppException(this.message);

  static AppException from(Object error) {
    return AppException(error.toString());
  }

  @override
  String toString() => message;
}

