import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';

/// One row inside "Order details" — image, name, quantity badge, price.
class OrderItemTile extends StatelessWidget {
  final OrderItem item;

  const OrderItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item.imageUrl != null
                ? Image.network(
                    item.imageUrl!,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (context, object, stackTrace) =>
                        _placeholderImage(),
                  )
                : _placeholderImage(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(color: AppColors.grey, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.currency} ${item.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'X${item.quantity}',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 44,
      height: 44,
      color: AppColors.lightPink,
      child: Icon(Icons.local_florist, color: AppColors.primary, size: 20),
    );
  }
}
