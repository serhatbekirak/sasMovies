import 'package:sasMovie/api/models/ResponseError.dart';

class CustomException implements Exception {
  final String _message;
  final String _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message]): super(message, "Error During Communication: ",);
}

class BadRequestException extends CustomException {
  BadRequestException([ResponseError responseError]) : super(responseError.statusMessage, "Invalid Request: ",);
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([ResponseError responseError]) : super(responseError.statusMessage, "Unauthorised: ");
}
