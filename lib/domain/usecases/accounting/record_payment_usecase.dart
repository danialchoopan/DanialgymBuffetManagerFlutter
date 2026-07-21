import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/accounting/payment_entity.dart';
import '../../../domain/repositories/accounting_repository.dart';

class RecordPaymentUseCase {
  final AccountingRepository _repository;

  RecordPaymentUseCase(this._repository);

  Future<Either<Failure, void>> call(PaymentEntity payment) async {
    return await _repository.addPayment(payment);
  }
}