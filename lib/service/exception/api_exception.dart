class ApiException implements Exception {
  final String errorMessage;
  final int errorCode;

  ApiException(this.errorMessage, this.errorCode);
}