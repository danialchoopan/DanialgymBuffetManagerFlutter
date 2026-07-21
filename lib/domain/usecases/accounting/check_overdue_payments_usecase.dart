import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/repositories/accounting_repository.dart';

class CheckOverduePaymentsUseCase {
  final AccountingRepository _repository;

  CheckOverduePaymentsUseCase(this._repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> call() async {
    final result = await _repository.getPaymentsByStatus('overdue');
    return result.fold(
      (failure) => Left(failure),
      (payments) {
        final overdueList = payments.map((payment) {
          return {
            'id': payment.id,
            'member_id': payment.memberId,
            'amount': payment.amount,
            'payment_date': payment.paymentDate,
            'reference': payment.reference,
          };
        }).toList();
        return Right(overdueList);
      },
    );
  }
}