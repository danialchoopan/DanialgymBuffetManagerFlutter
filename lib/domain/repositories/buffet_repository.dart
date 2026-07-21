import 'package:dartz/dartz.dart';
import '../entities/buffet/buffet_entities.dart';
import '../entities/value_objects/enums.dart';
import '../entities/value_objects/value_objects.dart';
import '../errors/failures.dart';

abstract class BuffetRepository {
  // Product Operations
  Future<Either<Failure, ProductEntity>> addProduct(ProductEntity product);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(String id);
  Future<Either<Failure, ProductEntity?>> getProductById(String id);
  Future<Either<Failure, ProductEntity?>> getProductByBarcode(String barcode);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String categoryId);
  Future<Either<Failure, List<ProductEntity>>> getActiveProducts();
  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts();
  Future<Either<Failure, List<ProductEntity>>> getOutOfStockProducts();
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
  Future<Either<Failure, List<ProductEntity>>> getProductsBySupplier(String supplier);
  
  // Stock Operations
  Future<Either<Failure, void>> updateStock(String productId, double quantity, InventoryReason reason);
  Future<Either<Failure, void>> addStock(String productId, double quantity, String? referenceId);
  Future<Either<Failure, void>> reduceStock(String productId, double quantity, String? referenceId);
  Future<Either<Failure, void>> adjustStock(String productId, double newQuantity, String reason);
  Future<Either<Failure, List<InventoryTransactionEntity>>> getInventoryTransactions(String productId);
  Future<Either<Failure, List<InventoryTransactionEntity>>> getInventoryTransactionsByDateRange(
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, double>> getCurrentStock(String productId);
  Future<Either<Failure, Money>> getStockValue(String productId);
  Future<Either<Failure, Money>> getTotalStockValue();
  
  // Order Operations
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order);
  Future<Either<Failure, OrderEntity>> updateOrder(OrderEntity order);
  Future<Either<Failure, void>> cancelOrder(String orderId);
  Future<Either<Failure, OrderEntity?>> getOrderById(String id);
  Future<Either<Failure, OrderEntity?>> getOrderByNumber(String orderNumber);
  Future<Either<Failure, List<OrderEntity>>> getAllOrders();
  Future<Either<Failure, List<OrderEntity>>> getOrdersByDate(DateTime date);
  Future<Either<Failure, List<OrderEntity>>> getOrdersByDateRange(DateTime start, DateTime end);
  Future<Either<Failure, List<OrderEntity>>> getOrdersByMemberId(String memberId);
  Future<Either<Failure, List<OrderEntity>>> getOrdersByStatus(OrderStatus status);
  Future<Either<Failure, List<OrderEntity>>> getTodayOrders();
  Future<Either<Failure, OrderEntity>> updateOrderStatus(String orderId, OrderStatus status);
  Future<Either<Failure, OrderEntity>> markOrderAsPaid(String orderId, PaymentMethod method);
  
  // Sales Summary
  Future<Either<Failure, SalesSummaryEntity>> getTodaySalesSummary();
  Future<Either<Failure, SalesSummaryEntity>> getSalesSummaryByDate(DateTime date);
  Future<Either<Failure, SalesSummaryEntity>> getSalesSummaryByDateRange(DateTime start, DateTime end);
  Future<Either<Failure, List<Map<String, dynamic>>>> getTopSellingProducts(DateTime start, DateTime end, int limit);
  Future<Either<Failure, Map<String, double>>> getSalesByCategory(DateTime start, DateTime end);
  Future<Either<Failure, Money>> getTotalSalesByDateRange(DateTime start, DateTime end);
  
  // Category Operations
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllCategories();
  Future<Either<Failure, Map<String, dynamic>>> getCategoryById(String id);
  Future<Either<Failure, Map<String, dynamic>>> addCategory(Map<String, dynamic> category);
  Future<Either<Failure, Map<String, dynamic>>> updateCategory(Map<String, dynamic> category);
  Future<Either<Failure, void>> deleteCategory(String id);
  
  // Statistics
  Future<Either<Failure, int>> getProductCount();
  Future<Either<Failure, int>> getOrderCount();
  Future<Either<Failure, Map<String, int>>> getOrdersByStatusCount();
  Future<Either<Failure, double>> getAverageOrderValue();
  Future<Either<Failure, int>> getProductsSoldCount(DateTime start, DateTime end);
}