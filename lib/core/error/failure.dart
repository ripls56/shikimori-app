import 'package:equatable/equatable.dart';

///Failure for
abstract base class Failure extends Equatable {
  ///Can add a stack trace or a message, or both
  const Failure({this.message, this.stackTrace});

  ///Exception reason
  final String? message;

  ///Stack trace
  final String? stackTrace;

  @override
  List<Object?> get props => [message, stackTrace];
}

///Server failure
///
///Use in repositories
base class ServerFailure extends Failure {
  ///Can add a stack trace or a message, or both
  const ServerFailure({super.message, super.stackTrace});
}

///Local failure
///
///Use in repositories
base class LocalFailure extends Failure {
  ///Can add a stack trace or a message, or both
  const LocalFailure({super.message, super.stackTrace});
}

///Auth failure
///
///Use in repositories
base class AuthFailure extends Failure {
  ///Can add a stack trace or a message, or both
  const AuthFailure({super.message, super.stackTrace});
}
