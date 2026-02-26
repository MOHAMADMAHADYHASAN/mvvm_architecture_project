class AppException implements Exception {
  late final prefix;
  late final message;

  AppException([this.prefix, this.message]);

  @override
  String toString() {
    return " $prefix:$message ";
  }
}

// data featch exception......................
class FetchDataException extends AppException {
  FetchDataException([String? message, String? prefix]) : super("Error During Communication:", message);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? prefix])
    : super("Invalid request:", message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message, String? prefix])
    : super("Unauthorised request:", message);
}
