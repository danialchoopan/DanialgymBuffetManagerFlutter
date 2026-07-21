import 'package:flutter/foundation.dart';
import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  static final ErrorHandler _instance = ErrorHandler._();
  factory ErrorHandler() => _instance;
  ErrorHandler._();

  Failure handleError(dynamic error, StackTrace? stackTrace) {
    debugPrint('Error: $error');
    debugPrint('StackTrace: $stackTrace');

    if (error is AppException) {
      return _handleAppException(error);
    }

    return UnexpectedFailure(
      message: error.toString(),
      details: stackTrace?.toString(),
    );
  }

  Failure _handleAppException(AppException exception) {
    switch (exception.runtimeType) {
      case DatabaseException:
        return DatabaseFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
      case CacheException:
        return CacheFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
      case ValidationException:
        return ValidationFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
      case AuthenticationException:
        return AuthenticationFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
      case PermissionException:
        return PermissionFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
      case NotFoundException:
        return NotFoundFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
      case FileException:
        return FileFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
      default:
        return UnexpectedFailure(
          message: exception.message,
          code: exception.code,
          details: exception.details,
        );
    }
  }
}