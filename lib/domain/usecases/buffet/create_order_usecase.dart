import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/buffet/order_entity.dart';
import '../../../domain/entities/buffet/order_item_entity.dart';
import '../../../domain/repositories/buffet_repository.dart';

class CreateOrderUseCase {
  final BuffetRepository _repository;

  CreateOrderUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required OrderEntity order,
    required List<OrderItemEntity> items,
  }) async {
    return await _repository.createOrder(order, items);
  }
}