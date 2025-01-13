class ServerException implements Exception {
  late final String message;

  ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

class OfflineException implements Exception {}

class WeekPassException implements Exception {}

class ExistedAccountException implements Exception {}

class NoUserFoundException implements Exception {}

class WrongPasswordException implements Exception {}

class TooManyRequestsException implements Exception {}

class BadRequest implements Exception {
  final String message;
  BadRequest(this.message);
  @override
  String toString() {
    return message;
  }
}

class InvalidToken implements Exception {
  final String message;

  InvalidToken(this.message);

  @override
  String toString() {
    return 'TokenInvalidException: $message';
  }
}
