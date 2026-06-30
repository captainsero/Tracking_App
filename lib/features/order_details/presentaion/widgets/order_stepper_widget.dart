import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

/// The thin 5-segment progress bar under the app bar.
/// Purely presentational — takes a 0-based [activeStep] and a [stepCount],
/// no knowledge of what status maps to what step. That logic lives in
/// [OrderStatus.stepIndex] so this widget stays reusable for any stepper.
class OrderProgressStepper extends StatelessWidget {
  final int activeStep;
  final int stepCount;

  const OrderProgressStepper({
    super.key,
    required this.activeStep,
    this.stepCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(stepCount, (index) {
        final isActive = index <= activeStep;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == stepCount - 1 ? 0 : 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 4,
                color: isActive ? AppColors.success : AppColors.lightGrey,
              ),
            ),
          ),
        );
      }),
    );
  }
}
