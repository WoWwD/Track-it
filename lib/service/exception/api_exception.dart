class ApiException {
  final String errorMessage;
  final int errorCode;

  ApiException({required this.errorMessage, required this.errorCode});
}