import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic details;

  const Failure({
    required this.message,
    this.code,
    this.details,
  });

  @override
  List<Object?> get props => [message, code, details];
}

// Member Failures
class MemberNotFoundFailure extends Failure {
  const MemberNotFoundFailure({
    String message = 'Member not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'MEMBER_NOT_FOUND', details: details);
}

class DuplicatePhoneFailure extends Failure {
  const DuplicatePhoneFailure({
    String message = 'A member with this phone number already exists',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'DUPLICATE_PHONE', details: details);
}

class InvalidPhoneFormatFailure extends Failure {
  const InvalidPhoneFormatFailure({
    String message = 'Invalid phone number format',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INVALID_PHONE_FORMAT', details: details);
}

class MembershipExpiredFailure extends Failure {
  const MembershipExpiredFailure({
    String message = 'Member membership has expired',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'MEMBERSHIP_EXPIRED', details: details);
}

class MemberBlockedFailure extends Failure {
  const MemberBlockedFailure({
    String message = 'Member is blocked from accessing the gym',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'MEMBER_BLOCKED', details: details);
}

class DuplicateMemberFailure extends Failure {
  const DuplicateMemberFailure({
    String message = 'A member with this information already exists',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'DUPLICATE_MEMBER', details: details);
}

// Payment Failures
class PaymentVerificationFailure extends Failure {
  const PaymentVerificationFailure({
    String message = 'Payment verification failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'PAYMENT_VERIFICATION_FAILED', details: details);
}

class OverduePaymentFailure extends Failure {
  const OverduePaymentFailure({
    String message = 'Member has overdue payments',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'OVERDUE_PAYMENT', details: details);
}

class InsufficientPaymentFailure extends Failure {
  const InsufficientPaymentFailure({
    String message = 'Payment amount is insufficient',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INSUFFICIENT_PAYMENT', details: details);
}

class PaymentAlreadyProcessedFailure extends Failure {
  const PaymentAlreadyProcessedFailure({
    String message = 'Payment has already been processed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'PAYMENT_ALREADY_PROCESSED', details: details);
}

// Product Failures
class ProductNotFoundFailure extends Failure {
  const ProductNotFoundFailure({
    String message = 'Product not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'PRODUCT_NOT_FOUND', details: details);
}

class DuplicateProductFailure extends Failure {
  const DuplicateProductFailure({
    String message = 'A product with this barcode already exists',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'DUPLICATE_PRODUCT', details: details);
}

class InsufficientStockFailure extends Failure {
  final double available;
  final double requested;

  const InsufficientStockFailure({
    String message = 'Insufficient stock',
    String? code,
    dynamic details,
    required this.available,
    required this.requested,
  }) : super(message: message, code: code ?? 'INSUFFICIENT_STOCK', details: details);

  @override
  List<Object?> get props => [message, code, details, available, requested];
}

class ProductInactiveFailure extends Failure {
  const ProductInactiveFailure({
    String message = 'Product is not active',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'PRODUCT_INACTIVE', details: details);
}

// Order Failures
class OrderNotFoundFailure extends Failure {
  const OrderNotFoundFailure({
    String message = 'Order not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'ORDER_NOT_FOUND', details: details);
}

class InvalidOrderStatusFailure extends Failure {
  const InvalidOrderStatusFailure({
    String message = 'Invalid order status for this operation',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INVALID_ORDER_STATUS', details: details);
}

class OrderAlreadyCancelledFailure extends Failure {
  const OrderAlreadyCancelledFailure({
    String message = 'Order has already been cancelled',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'ORDER_ALREADY_CANCELLED', details: details);
}

class EmptyOrderFailure extends Failure {
  const EmptyOrderFailure({
    String message = 'Order must have at least one item',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'EMPTY_ORDER', details: details);
}

// Transaction Failures
class InvalidTransactionFailure extends Failure {
  const InvalidTransactionFailure({
    String message = 'Invalid transaction',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INVALID_TRANSACTION', details: details);
}

class TransactionNotFoundFailure extends Failure {
  const TransactionNotFoundFailure({
    String message = 'Transaction not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'TRANSACTION_NOT_FOUND', details: details);
}

class DuplicateTransactionFailure extends Failure {
  const DuplicateTransactionFailure({
    String message = 'Duplicate transaction detected',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'DUPLICATE_TRANSACTION', details: details);
}

// Invoice Failures
class InvoiceNotFoundFailure extends Failure {
  const InvoiceNotFoundFailure({
    String message = 'Invoice not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INVOICE_NOT_FOUND', details: details);
}

class InvoiceAlreadyPaidFailure extends Failure {
  const InvoiceAlreadyPaidFailure({
    String message = 'Invoice has already been paid',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INVOICE_ALREADY_PAID', details: details);
}

class InvoiceOverdueFailure extends Failure {
  const InvoiceOverdueFailure({
    String message = 'Invoice is overdue',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INVOICE_OVERDUE', details: details);
}

// Workout Failures
class ProgramNotFoundFailure extends Failure {
  const ProgramNotFoundFailure({
    String message = 'Workout program not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'PROGRAM_NOT_FOUND', details: details);
}

class ExerciseNotFoundFailure extends Failure {
  const ExerciseNotFoundFailure({
    String message = 'Exercise not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'EXERCISE_NOT_FOUND', details: details);
}

class ProgramAlreadyAssignedFailure extends Failure {
  const ProgramAlreadyAssignedFailure({
    String message = 'Program is already assigned to this member',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'PROGRAM_ALREADY_ASSIGNED', details: details);
}

class InvalidWorkoutLogFailure extends Failure {
  const InvalidWorkoutLogFailure({
    String message = 'Invalid workout log data',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INVALID_WORKOUT_LOG', details: details);
}

// Trainer Failures
class TrainerNotFoundFailure extends Failure {
  const TrainerNotFoundFailure({
    String message = 'Trainer not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'TRAINER_NOT_FOUND', details: details);
}

class TrainerNotAvailableFailure extends Failure {
  const TrainerNotAvailableFailure({
    String message = 'Trainer is not available at this time',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'TRAINER_NOT_AVAILABLE', details: details);
}

class TrainerFullyBookedFailure extends Failure {
  const TrainerFullyBookedFailure({
    String message = 'Trainer is fully booked',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'TRAINER_FULLY_BOOKED', details: details);
}

class MemberAlreadyAssignedFailure extends Failure {
  const MemberAlreadyAssignedFailure({
    String message = 'Member is already assigned to this trainer',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'MEMBER_ALREADY_ASSIGNED', details: details);
}

// Attendance Failures
class AlreadyCheckedInFailure extends Failure {
  const AlreadyCheckedInFailure({
    String message = 'Member is already checked in',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'ALREADY_CHECKED_IN', details: details);
}

class NotCheckedInFailure extends Failure {
  const NotCheckedInFailure({
    String message = 'Member is not checked in',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'NOT_CHECKED_IN', details: details);
}

class AttendanceNotFoundFailure extends Failure {
  const AttendanceNotFoundFailure({
    String message = 'Attendance record not found',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'ATTENDANCE_NOT_FOUND', details: details);
}

// Database Failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    String message = 'Database error occurred',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'DATABASE_ERROR', details: details);
}

class DatabaseConnectionFailure extends Failure {
  const DatabaseConnectionFailure({
    String message = 'Failed to connect to database',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'DATABASE_CONNECTION_ERROR', details: details);
}

class DatabaseQueryFailure extends Failure {
  const DatabaseQueryFailure({
    String message = 'Database query failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'DATABASE_QUERY_ERROR', details: details);
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    String message = 'Validation error',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'VALIDATION_ERROR', details: details);
}

class RequiredFieldFailure extends Failure {
  final String fieldName;

  const RequiredFieldFailure({
    String message = 'Required field is missing',
    String? code,
    dynamic details,
    required this.fieldName,
  }) : super(message: message, code: code ?? 'REQUIRED_FIELD', details: details);

  @override
  List<Object?> get props => [message, code, details, fieldName];
}

class InvalidFormatFailure extends Failure {
  final String fieldName;
  final String expectedFormat;

  const InvalidFormatFailure({
    String message = 'Invalid format',
    String? code,
    dynamic details,
    required this.fieldName,
    required this.expectedFormat,
  }) : super(message: message, code: code ?? 'INVALID_FORMAT', details: details);

  @override
  List<Object?> get props => [message, code, details, fieldName, expectedFormat];
}

// Authorization Failures
class UnauthorizedAccessFailure extends Failure {
  const UnauthorizedAccessFailure({
    String message = 'Unauthorized access',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'UNAUTHORIZED_ACCESS', details: details);
}

class InsufficientPermissionsFailure extends Failure {
  const InsufficientPermissionsFailure({
    String message = 'Insufficient permissions',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'INSUFFICIENT_PERMISSIONS', details: details);
}

// Concurrency Failures
class ConcurrentUpdateFailure extends Failure {
  const ConcurrentUpdateFailure({
    String message = 'Data has been modified by another user',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'CONCURRENT_UPDATE', details: details);
}

// Backup/Export Failures
class BackupFailure extends Failure {
  const BackupFailure({
    String message = 'Backup operation failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'BACKUP_FAILED', details: details);
}

class RestoreFailure extends Failure {
  const RestoreFailure({
    String message = 'Restore operation failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'RESTORE_FAILED', details: details);
}

class ExportFailure extends Failure {
  const ExportFailure({
    String message = 'Export operation failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'EXPORT_FAILED', details: details);
}

class ImportFailure extends Failure {
  const ImportFailure({
    String message = 'Import operation failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'IMPORT_FAILED', details: details);
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'Network error occurred',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'NETWORK_ERROR', details: details);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    String message = 'Operation timed out',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'TIMEOUT', details: details);
}

// General Failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    String message = 'An unexpected error occurred',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'UNEXPECTED_ERROR', details: details);
}

class CacheFailure extends Failure {
  const CacheFailure({
    String message = 'Cache operation failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'CACHE_ERROR', details: details);
}

class FileOperationFailure extends Failure {
  const FileOperationFailure({
    String message = 'File operation failed',
    String? code,
    dynamic details,
  }) : super(message: message, code: code ?? 'FILE_OPERATION_ERROR', details: details);
}