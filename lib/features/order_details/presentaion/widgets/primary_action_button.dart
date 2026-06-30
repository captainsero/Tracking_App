import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

/// The bottom pink CTA ("Arrived at Pickup point" in the design).
///
/// Deliberately dumb: it doesn't know about Order, OrderStatus, Cubit,
/// or Firebase. It just renders a label, reports taps via [onPressed],
/// and shows a spinner when [isLoading] is true. When OrderCubit lands,
/// the call site becomes:
///
///   BlocBuilder_OrderCubit, OrderState_(
///     builder: (context, state) => PrimaryActionButton(
///       label: state.order.status.nextActionLabel,
///       isLoading: state.isUpdating,
///       onPressed: () => context.read _OrderCubit_().advanceStatus(),
///     ),
///   )
///
/// and nothing in this file needs to change.
class PrimaryActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
