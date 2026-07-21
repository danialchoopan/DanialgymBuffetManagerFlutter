import '../entities/buffet/product_entity.dart';
import '../entities/buffet/category_entity.dart';
import '../entities/buffet/order_entity.dart';
import '../entities/buffet/order_item_entity.dart';
import '../entities/buffet/inventory_entity.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class BuffetRepository {
  // Products
  ResultFuture<List<ProductEntity>> getAllProducts();
  ResultFuture<ProductEntity?> getProductById(String id);
  ResultFuture<List<ProductEntity>> getProductsByCategory(String categoryId);
  ResultFuture<List<ProductEntity>> searchProducts(String query);
  ResultFuture<void> addProduct(ProductEntity product);
  ResultFuture<void> updateProduct(ProductEntity product);
  ResultFuture<void> deleteProduct(String id);

  // Categories
  ResultFuture<List<CategoryEntity>> getAllCategories();
  ResultFuture<CategoryEntity?> getCategoryById(String id);
  ResultFuture<void> addCategory(CategoryEntity category);
  ResultFuture<void> updateCategory(CategoryEntity category);
  ResultFuture<void> deleteCategory(String id);

  // Orders
  ResultFuture<List<OrderEntity>> getAllOrders();
  ResultFuture<OrderEntity?> getOrderById(String id);
  ResultFuture<List<OrderEntity>> getOrdersByMemberId(String memberId);
  ResultFuture<List<OrderEntity>> getOrdersByStatus(String status);
  ResultFuture<List<OrderEntity>> getOrdersByDate(DateTime date);
  ResultFuture<void> createOrder(OrderEntity order, List<OrderItemEntity> items);
  ResultFuture<void> updateOrderStatus(String orderId, String status);

  // Inventory
  ResultFuture<List<InventoryEntity>> getAllInventory();
  ResultFuture<InventoryEntity?> getInventoryByProductId(String productId);
  ResultFuture<List<InventoryEntity>> getLowStockItems();
  ResultFuture<void> updateStock(String productId, int quantity, String type);
  ResultFuture<void> addInventoryItem(InventoryEntity inventory);
  ResultFuture<void> updateInventoryItem(InventoryEntity inventory);
}