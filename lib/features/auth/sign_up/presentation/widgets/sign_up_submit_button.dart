import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/generated/l10n.dart';

class SignUpSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const SignUpSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusSize.r30),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: AppSize.s24,
                height: AppSize.s24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                S.of(context).continueText,
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: FontSize.s16,
                  fontFamily: FontConstants.interFamily,
                ),
              ),
      ),
    );
  }
}
