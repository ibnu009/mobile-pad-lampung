import 'package:equatable/equatable.dart';

import '../core/data/model/response/error_response.dart';

abstract class Failure extends Equatable {
  final ErrorResponse message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(ErrorResponse message) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(ErrorResponse message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(ErrorResponse message) : super(message);
}

class SSLFailure extends Failure {
  const SSLFailure(ErrorResponse message) : super(message);
}