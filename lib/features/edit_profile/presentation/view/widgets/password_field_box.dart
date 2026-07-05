import 'package:flutter/material.dart';
import 'package:tracking_app/generated/l10n.dart';

class PasswordFieldBox extends StatelessWidget {
  const PasswordFieldBox({super.key, required this.onChangeTap});
  final VoidCallback onChangeTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor, width: 0.8),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline_rounded, color: colorScheme.primary, size: 17),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '••••••••',
              style: theme.textTheme.bodyMedium?.copyWith(letterSpacing: 2),
            ),
          ),
          GestureDetector(
            onTap: onChangeTap,
            child: Text(
              S.of(context).changePassword,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
