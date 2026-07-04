import 'package:flutter/material.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

class PasswordFieldBox extends StatelessWidget {
  const PasswordFieldBox({super.key, required this.onChangeTap});
  final VoidCallback onChangeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 17),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '••••••••',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.hintColor,
                letterSpacing: 2,
              ),
            ),
          ),
          GestureDetector(
            onTap: onChangeTap,
            child: Text(
              S.of(context).changePassword,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
