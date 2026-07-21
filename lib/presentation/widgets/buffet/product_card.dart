import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String categoryName;
  final int stock;
  final String? imagePath;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.categoryName,
    required this.stock,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.secondaryLight,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      categoryName,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildStockBadge(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockBadge() {
    Color backgroundColor;
    Color textColor;

    if (stock <= 0) {
      backgroundColor = AppColors.outOfStock;
      textColor = AppColors.white;
    } else if (stock <= 10) {
      backgroundColor = AppColors.lowStock;
      textColor = AppColors.white;
    } else {
      backgroundColor = AppColors.inStock;
      textColor = AppColors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Stock: $stock',
        style: AppTypography.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String memberName;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.memberName,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderNumber,
                          style: AppTypography.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          memberName,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    createdAt.toString().substring(0, 16),
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = AppColors.success;
        textColor = AppColors.white;
        break;
      case 'pending':
        backgroundColor = AppColors.pending;
        textColor = AppColors.white;
        break;
      case 'cancelled':
        backgroundColor = AppColors.expiredMembership;
        textColor = AppColors.white;
        break;
      default:
        backgroundColor = AppColors.grey300;
        textColor = AppColors.grey700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final VoidCallback? onCheckout;
  final ValueChanged<int>? onQuantityChanged;
  final ValueChanged<int>? onRemoveItem;

  const CartWidget({
    super.key,
    required this.items,
    required this.totalAmount,
    this.onCheckout,
    this.onQuantityChanged,
    this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'Cart is empty',
                style: AppTypography.bodyMedium,
              ),
            )
          else ...[
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['name'] ?? ''),
                    subtitle: Text('\$${item['price']?.toStringAsFixed(2) ?? '0.00'}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            final newQuantity = (item['quantity'] ?? 1) - 1;
                            if (newQuantity > 0) {
                              onQuantityChanged?.call(newQuantity);
                            } else {
                              onRemoveItem?.call(index);
                            }
                          },
                        ),
                        Text(
                          '${item['quantity'] ?? 1}',
                          style: AppTypography.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            final newQuantity = (item['quantity'] ?? 1) + 1;
                            onQuantityChanged?.call(newQuantity);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: AppTypography.titleLarge,
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: items.isEmpty ? null : onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}