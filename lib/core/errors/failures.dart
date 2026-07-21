import 'package:dartz/dartz.dart';
import 'exceptions.dart';

abstract class Failure {
  final String message;
  final String? code;
  final dynamic details;

  const Failure({
    required this.message,
    this.code,
    this.details,
  });
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.code = 'DB_ERROR',
    super.details,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code = 'CACHE_ERROR',
    super.details,
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.details,
  });
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required super.message,
    super.code = 'AUTH_ERROR',
    super.details,
  });
}

class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code = 'PERMISSION_ERROR',
    super.details,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code = 'NOT_FOUND',
    super.details,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code = 'SERVER_ERROR',
    super.details,
  });
}

class FileFailure extends Failure {
  const FileFailure({
    required super.message,
    super.code = 'FILE_ERROR',
    super.details,
  });
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.code = 'UNEXPECTED_ERROR',
    super.details,
  });
}

extension FailureToException on Failure {
  AppException toException() {
    if (this is DatabaseFailure) {
      return DatabaseException(message: message, code: code, details: details);
    } else if (this is CacheFailure) {
      return CacheException(message: message, code: code, details: details);
    } else if (this is ValidationFailure) {
      return ValidationException(message: message, code: code, details: details);
    } else if (this is AuthenticationFailure) {
      return AuthenticationException(message: message, code: code, details: details);
    } else {
      return AppException(message: message, code: code, details: details);
    }
  }
}

extension ExceptionToFailure on Exception {
  Failure toFailure() {
    if (this is AppException) {
      final appException = this as AppException;
      return UnexpectedFailure(
        message: appException.message,
        code: appException.code,
        details: appException.details,
      );
    }
    return UnexpectedFailure(message: toString());
  }
}

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;