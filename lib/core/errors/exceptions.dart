class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException({
    required this.message,
    this.code,
    this.details,
  });

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

class DatabaseException extends AppException {
  DatabaseException({
    required super.message,
    super.code,
    super.details,
  });
}

class CacheException extends AppException {
  CacheException({
    required super.message,
    super.code,
    super.details,
  });
}

class ValidationException extends AppException {
  ValidationException({
    required super.message,
    super.code,
    super.details,
  });
}

class AuthenticationException extends AppException {
  AuthenticationException({
    required super.message,
    super.code = 'AUTH_ERROR',
    super.details,
  });
}

class PermissionException extends AppException {
  PermissionException({
    required super.message,
    super.code = 'PERMISSION_ERROR',
    super.details,
  });
}

class NotFoundException extends AppException {
  NotFoundException({
    required super.message,
    super.code = 'NOT_FOUND',
    super.details,
  });
}

class ServerException extends AppException {
  ServerException({
    required super.message,
    super.code = 'SERVER_ERROR',
    super.details,
  });
}

class FileException extends AppException {
  FileException({
    required super.message,
    super.code = 'FILE_ERROR',
    super.details,
  });
}