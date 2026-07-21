import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../repositories/accounting_repository.dart';
import '../entities/accounting/accounting_entities.dart';
import '../entities/member/member_payment_entity.dart';
import '../entities/value_objects/enums.dart';
import '../entities/value_objects/value_objects.dart';

// Use Case: Record Income
class RecordIncomeUseCase {
  final AccountingRepository _repository;

  RecordIncomeUseCase(this._repository);

  Future<Either<Failure, TransactionEntity>> call(RecordIncomeParams params) async {
    if (params.amount.amount <= 0) {
      return const Left(ValidationFailure(message: 'Amount must be greater than 0'));
    }
    return await _repository.recordIncome(
      amount: params.amount,
      category: params.category,
      description: params.description,
      referenceId: params.referenceId,
      referenceType: params.referenceType,
    );
  }
}

class RecordIncomeParams {
  final Money amount;
  final String category;
  final String? description;
  final String? referenceId;
  final TransactionReferenceType? referenceType;

  const RecordIncomeParams({
    required this.amount,
    required this.category,
    this.description,
    this.referenceId,
    this.referenceType,
  });
}

// Use Case: Record Expense
class RecordExpenseUseCase {
  final AccountingRepository _repository;

  RecordExpenseUseCase(this._repository);

  Future<Either<Failure, TransactionEntity>> call(RecordExpenseParams params) async {
    if (params.amount.amount <= 0) {
      return const Left(ValidationFailure(message: 'Amount must be greater than 0'));
    }
    return await _repository.recordExpense(
      amount: params.amount,
      category: params.category,
      description: params.description,
      referenceId: params.referenceId,
      referenceType: params.referenceType,
    );
  }
}

class RecordExpenseParams {
  final Money amount;
  final String category;
  final String? description;
  final String? referenceId;
  final TransactionReferenceType? referenceType;

  const RecordExpenseParams({
    required this.amount,
    required this.category,
    this.description,
    this.referenceId,
    this.referenceType,
  });
}

// Use Case: Generate Daily Report
class GenerateDailyReportUseCase {
  final AccountingRepository _repository;

  GenerateDailyReportUseCase(this._repository);

  Future<Either<Failure, DailyReportEntity>> call(DateTime date) async {
    return await _repository.generateDailyReport(date);
  }
}

// Use Case: Generate Monthly Report
class GenerateMonthlyReportUseCase {
  final AccountingRepository _repository;

  GenerateMonthlyReportUseCase(this._repository);

  Future<Either<Failure, MonthlyReportEntity>> call(MonthlyReportParams params) async {
    return await _repository.generateMonthlyReport(params.year, params.month);
  }
}

class MonthlyReportParams {
  final int year;
  final int month;

  const MonthlyReportParams({
    required this.year,
    required this.month,
  });
}

// Use Case: Check Overdue Payments
class CheckOverduePaymentsUseCase {
  final AccountingRepository _repository;

  CheckOverduePaymentsUseCase(this._repository);

  Future<Either<Failure, List<MemberPaymentEntity>>> call() async {
    return await _repository.getOverduePayments();
  }
}

// Use Case: Send Payment Reminder
class SendPaymentReminderUseCase {
  final AccountingRepository _repository;

  SendPaymentReminderUseCase(this._repository);

  Future<Either<Failure, void>> call(String memberId) async {
    final summaryResult = await _repository.getMemberFinancialSummary(memberId);
    return summaryResult.fold(
      (failure) => Left(failure),
      (summary) {
        if (!summary.needsPaymentReminder) {
          return const Left(ValidationFailure(message: 'No payment reminder needed'));
        }
        // In a real app, this would send a notification
        return const Right(null);
      },
    );
  }
}

// Use Case: Generate Invoice
class GenerateInvoiceUseCase {
  final AccountingRepository _repository;

  GenerateInvoiceUseCase(this._repository);

  Future<Either<Failure, InvoiceEntity>> call(InvoiceEntity invoice) async {
    if (invoice.items.isEmpty) {
      return const Left(ValidationFailure(message: 'Invoice must have at least one item'));
    }
    if (invoice.total.amount <= 0) {
      return const Left(ValidationFailure(message: 'Invoice total must be greater than 0'));
    }
    return await _repository.generateInvoice(invoice);
  }
}

// Use Case: Get Profit Loss Statement
class GetProfitLossStatementUseCase {
  final AccountingRepository _repository;

  GetProfitLossStatementUseCase(this._repository);

  Future<Either<Failure, ProfitLossEntity>> call(ProfitLossParams params) async {
    return await _repository.getProfitLossStatement(params.startDate, params.endDate);
  }
}

class ProfitLossParams {
  final DateTime startDate;
  final DateTime endDate;

  const ProfitLossParams({
    required this.startDate,
    required this.endDate,
  });
}

// Use Case: Process Payment
class ProcessPaymentUseCase {
  final AccountingRepository _repository;

  ProcessPaymentUseCase(this._repository);

  Future<Either<Failure, MemberPaymentEntity>> call(MemberPaymentEntity payment) async {
    if (payment.amount.amount <= 0) {
      return const Left(ValidationFailure(message: 'Payment amount must be greater than 0'));
    }
    return await _repository.processPayment(payment);
  }
}

// Use Case: Get Member Financial Summary
class GetMemberFinancialSummaryUseCase {
  final AccountingRepository _repository;

  GetMemberFinancialSummaryUseCase(this._repository);

  Future<Either<Failure, MemberFinancialSummaryEntity>> call(String memberId) async {
    return await _repository.getMemberFinancialSummary(memberId);
  }
}

// Use Case: Get Overdue Invoices
class GetOverdueInvoicesUseCase {
  final AccountingRepository _repository;

  GetOverdueInvoicesUseCase(this._repository);

  Future<Either<Failure, List<InvoiceEntity>>> call() async {
    return await _repository.getOverdueInvoices();
  }
}

// Use Case: Update Invoice Payment
class UpdateInvoicePaymentUseCase {
  final AccountingRepository _repository;

  UpdateInvoicePaymentUseCase(this._repository);

  Future<Either<Failure, InvoiceEntity>> call(UpdateInvoicePaymentParams params) async {
    if (params.amount.amount <= 0) {
      return const Left(ValidationFailure(message: 'Payment amount must be greater than 0'));
    }
    return await _repository.updateInvoicePayment(params.invoiceId, params.amount);
  }
}

class UpdateInvoicePaymentParams {
  final String invoiceId;
  final Money amount;

  const UpdateInvoicePaymentParams({
    required this.invoiceId,
    required this.amount,
  });
}