import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

/// The two bottom rows: "Total" and "Payment method".
/// Split into a small reusable [_SummaryRow] so adding more rows later
/// (e.g. delivery fee, discount) is a one-liner, not a copy-paste.
class OrderSummaryCard extends StatelessWidget {
  final double total;
  final String currency;
  final String paymentMethod;

  const OrderSummaryCard({
    super.key,
    required this.total,
    required this.paymentMethod,
    this.currency = 'EGP',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryRow(
          label: 'Total',
          value: '$currency ${total.toStringAsFixed(0)}',
          valueWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        _SummaryRow(label: 'Payment method', value: paymentMethod),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final FontWeight valueWeight;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: valueWeight,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
