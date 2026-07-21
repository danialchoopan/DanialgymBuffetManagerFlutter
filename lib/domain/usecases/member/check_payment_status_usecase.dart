import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/repositories/accounting_repository.dart';

class CheckPaymentStatusUseCase {
  final AccountingRepository _repository;

  CheckPaymentStatusUseCase(this._repository);

  Future<Either<Failure, bool>> call(String memberId) async {
    final result = await _repository.getPaymentsByMemberId(memberId);
    return result.fold(
      (failure) => Left(failure),
      (payments) {
        final hasPendingPayments = payments.any(
          (payment) => payment.status == 'pending' || payment.status == 'overdue',
        );
        return Right(!hasPendingPayments);
      },
    );
  }
}