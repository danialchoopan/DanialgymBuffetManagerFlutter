import '../../../core/database/entities/accounting/payment_entity.dart';
import '../../../core/database/entities/accounting/transaction_entity.dart';
import '../../../core/database/entities/accounting/expense_entity.dart';
import '../../../core/database/entities/accounting/invoice_entity.dart';

class AccountingMapper {
  static PaymentEntity toPaymentEntity(Map<String, dynamic> map) {
    return PaymentEntity(
      id: map['id'],
      memberId: map['member_id'],
      invoiceId: map['invoice_id'],
      amount: map['amount'].toDouble(),
      paymentMethod: map['payment_method'],
      paymentDate: DateTime.parse(map['payment_date']),
      status: map['status'],
      reference: map['reference'],
      description: map['description'],
      processedBy: map['processed_by'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  static Map<String, dynamic> toPaymentMap(PaymentEntity entity) {
    return {
      'id': entity.id,
      'member_id': entity.memberId,
      'invoice_id': entity.invoiceId,
      'amount': entity.amount,
      'payment_method': entity.paymentMethod,
      'payment_date': entity.paymentDate.toIso8601String(),
      'status': entity.status,
      'reference': entity.reference,
      'description': entity.description,
      'processed_by': entity.processedBy,
      'created_at': entity.createdAt.toIso8601String(),
    };
  }

  static TransactionEntity toTransactionEntity(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map['id'],
      type: map['type'],
      category: map['category'],
      amount: map['amount'].toDouble(),
      description: map['description'],
      referenceId: map['reference_id'],
      referenceType: map['reference_type'],
      paymentMethod: map['payment_method'],
      date: DateTime.parse(map['date']),
      createdBy: map['created_by'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  static Map<String, dynamic> toTransactionMap(TransactionEntity entity) {
    return {
      'id': entity.id,
      'type': entity.type,
      'category': entity.category,
      'amount': entity.amount,
      'description': entity.description,
      'reference_id': entity.referenceId,
      'reference_type': entity.referenceType,
      'payment_method': entity.paymentMethod,
      'date': entity.date.toIso8601String(),
      'created_by': entity.createdBy,
      'created_at': entity.createdAt.toIso8601String(),
    };
  }

  static ExpenseEntity toExpenseEntity(Map<String, dynamic> map) {
    return ExpenseEntity(
      id: map['id'],
      category: map['category'],
      description: map['description'],
      amount: map['amount'].toDouble(),
      vendor: map['vendor'],
      receiptPath: map['receipt_path'],
      paymentMethod: map['payment_method'],
      expenseDate: DateTime.parse(map['expense_date']),
      isRecurring: map['is_recurring'] ?? false,
      recurringFrequency: map['recurring_frequency'],
      notes: map['notes'],
      approvedBy: map['approved_by'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  static Map<String, dynamic> toExpenseMap(ExpenseEntity entity) {
    return {
      'id': entity.id,
      'category': entity.category,
      'description': entity.description,
      'amount': entity.amount,
      'vendor': entity.vendor,
      'receipt_path': entity.receiptPath,
      'payment_method': entity.paymentMethod,
      'expense_date': entity.expenseDate.toIso8601String(),
      'is_recurring': entity.isRecurring,
      'recurring_frequency': entity.recurringFrequency,
      'notes': entity.notes,
      'approved_by': entity.approvedBy,
      'created_at': entity.createdAt.toIso8601String(),
    };
  }

  static InvoiceEntity toInvoiceEntity(Map<String, dynamic> map) {
    return InvoiceEntity(
      id: map['id'],
      invoiceNumber: map['invoice_number'],
      memberId: map['member_id'],
      amount: map['amount'].toDouble(),
      taxAmount: map['tax_amount']?.toDouble() ?? 0,
      discountAmount: map['discount_amount']?.toDouble() ?? 0,
      totalAmount: map['total_amount'].toDouble(),
      status: map['status'],
      dueDate: DateTime.parse(map['due_date']),
      paidDate: map['paid_date'] != null ? DateTime.parse(map['paid_date']) : null,
      items: map['items'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  static Map<String, dynamic> toInvoiceMap(InvoiceEntity entity) {
    return {
      'id': entity.id,
      'invoice_number': entity.invoiceNumber,
      'member_id': entity.memberId,
      'amount': entity.amount,
      'tax_amount': entity.taxAmount,
      'discount_amount': entity.discountAmount,
      'total_amount': entity.totalAmount,
      'status': entity.status,
      'due_date': entity.dueDate.toIso8601String(),
      'paid_date': entity.paidDate?.toIso8601String(),
      'items': entity.items,
      'notes': entity.notes,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
    };
  }
}