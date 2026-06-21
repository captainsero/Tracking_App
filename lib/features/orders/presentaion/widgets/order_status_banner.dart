import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/features/orders/domain/entitty/order_status.dart';

/// The pink card showing "Status: Accepted / Order ID / date".
/// Status color could later vary per [status] (e.g. red for cancelled) —
/// that branching lives here since it's the one place that cares.
class OrderStatusBanner extends StatelessWidget {
  final OrderStatus status;
  final String orderId;
  final DateTime createdAt;

  const OrderStatusBanner({
    super.key,
    required this.status,
    required this.orderId,
    required this.createdAt,
  });

  Color get _statusColor {
    switch (status) {
      case OrderStatus.cancelled:
        return Colors.red;
      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'EEE, dd MMM yyyy, hh:mm a',
    ).format(createdAt);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status : ${status.label}',
            style: TextStyle(
              color: _statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Order ID : #$orderId',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formattedDate,
            style: TextStyle(color: AppColors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
