import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/repositories/buffet_repository.dart';

class UpdateStockUseCase {
  final BuffetRepository _repository;

  UpdateStockUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String productId,
    required int quantity,
    required String type,
  }) async {
    return await _repository.updateStock(productId, quantity, type);
  }
}