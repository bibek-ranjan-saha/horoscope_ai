class NetworkFailure {
  final String message;

  int? statusCode;
  NetworkFailure(this.message, {this.statusCode});
}
