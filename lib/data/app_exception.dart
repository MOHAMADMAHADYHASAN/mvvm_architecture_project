class AppException implements Exception {
  final String? prefix;
  final String? message;

  AppException({this.prefix, this.message});

  @override
  String toString() {
    return " $prefix:$message ";
  }
}

// data featch exception......................
class FetchDataException extends AppException {
  FetchDataException({String? message})
    : super(prefix: "Error During Communication:", message: message);
}

class BadRequestException extends AppException {
  BadRequestException({String? prefix, String? message})
    : super(prefix: "Invalid request:", message: message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? prefix, String? message})
    : super(prefix: "Unauthorised request:", message: message);
}

class InvalidInputException extends AppException {
  InvalidInputException({String? message}) : super(message: "Invalid request");
}
class NotFoundException extends AppException{
  NotFoundException({String? message}): super (prefix: "Not Found", message:message);
}
