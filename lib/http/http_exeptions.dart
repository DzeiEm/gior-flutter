class HttpException implements Exception {
  // tai ivyks privalomai
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}
