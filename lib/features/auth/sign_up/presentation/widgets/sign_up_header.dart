import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/generated/l10n.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.welcome,
          style: getBoldStyle(
            color: AppColors.black,
            fontSize: FontSize.s30,
            fontFamily: FontConstants.interFamily,
          ),
        ),
        const SizedBox(height: AppSize.s6),
        Text(
          l10n.applySubtitle,
          style: getRegularStyle(
            color: AppColors.grey,
            fontSize: FontSize.s16,
            fontFamily: FontConstants.interFamily,
          ),
        ),
      ],
    );
  }
}
