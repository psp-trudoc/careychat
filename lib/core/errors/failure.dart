import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class OfflineFailure extends Failure {
  const OfflineFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class InvalidTokenFailure extends Failure {
  const InvalidTokenFailure(super.message);
}

class NoUserFoundFailure extends Failure {
  const NoUserFoundFailure(super.message);
}

