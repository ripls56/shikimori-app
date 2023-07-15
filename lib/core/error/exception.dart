///Server exception
///
///Use to all server error related with data source
class ServerException implements Exception {
  ///Can add a stack trace or a message, or both
  ServerException({this.message, this.stackTrace});

  ///Exception reason
  final String? message;

  ///Stack trace
  final String? stackTrace;
}

///Client exception
///
///Use to all server error related with data source
class ClientException implements Exception {
  ///Can add a stack trace or a message, or both
  ClientException({this.message, this.stackTrace});

  ///Exception reason
  final String? message;

  ///Stack trace
  final String? stackTrace;
}

///Auth exception
class AuthException implements Exception {
  ///Can add a stack trace or a message, or both
  AuthException({this.message, this.stackTrace});

  ///Exception reason
  final String? message;

  ///Stack trace
  final String? stackTrace;
}

///Save exception
///
///Use to all local storage errors
class SaveException implements Exception {
  ///Can add a stack trace or a message, or both
  SaveException({this.message, this.stackTrace});

  ///Exception reason
  final String? message;

  ///Stack trace
  final String? stackTrace;
}

///Get token exception
///
///Use to all local storage errors
class GetTokenException implements Exception {
  ///Can add a stack trace or a message, or both
  GetTokenException({this.message, this.stackTrace});

  ///Exception reason
  final String? message;

  ///Stack trace
  final String? stackTrace;
}

///Delete exception
///
///Use to all local storage errors
class DeleteException implements Exception {
  ///Can add a stack trace or a message, or both
  DeleteException({this.message, this.stackTrace});

  ///Exception reason
  final String? message;

  ///Stack trace
  final String? stackTrace;
}
