import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/repositories/accounting_repository.dart';

class GenerateReportUseCase {
  final AccountingRepository _repository;

  GenerateReportUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call({
    required DateTime startDate,
    required DateTime endDate,
    String? type,
  }) async {
    final income = await _repository.getTotalIncome(startDate, endDate);
    final expenses = await _repository.getTotalExpenses(startDate, endDate);

    return income.fold(
      (failure) => Left(failure),
      (totalIncome) => expenses.fold(
        (failure) => Left(failure),
        (totalExpenses) {
          final profit = totalIncome - totalExpenses;
          return Right({
            'total_income': totalIncome,
            'total_expenses': totalExpenses,
            'net_profit': profit,
            'profit_margin': totalIncome > 0 ? (profit / totalIncome * 100) : 0.0,
            'start_date': startDate,
            'end_date': endDate,
          });
        },
      ),
    );
  }
}