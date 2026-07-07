import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/locale/locale_cubit.dart';
import 'package:tracking_app/generated/l10n.dart';

void showLanguagePickerSheet(BuildContext context) {
  final localeCubit = context.read<LocaleCubit>();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return BlocProvider.value(
        value: localeCubit,
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (ctx, currentLocale) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ──────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, left: 4),
                    child: Text(
                      S.current.language,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── English option ───────────────────────────────
                  LanguagePickerSheet(
                    flag: '🇬🇧',
                    label: S.of(context).english,
                    nativeLabel: S.of(context).english,
                    isSelected: currentLocale.languageCode == 'en',
                    onTap: () {
                      localeCubit.changeLocale(AppLanguage.english);
                      Navigator.pop(sheetContext);
                    },
                  ),

                  const SizedBox(height: 4),

                  // ── Arabic option ────────────────────────────────
                  LanguagePickerSheet(
                    flag: '🇸🇦',
                    label: S.of(context).arabic,
                    nativeLabel: S.of(context).arabic,
                    isSelected: currentLocale.languageCode == 'ar',
                    onTap: () {
                      localeCubit.changeLocale(AppLanguage.arabic);
                      Navigator.pop(sheetContext);
                    },
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class LanguagePickerSheet extends StatelessWidget {
  final String flag;
  final String label;
  final String nativeLabel;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguagePickerSheet({
    super.key,
    required this.flag,
    required this.label,
    required this.nativeLabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: primaryColor.withValues(alpha: 0.35),
                  width: 1.2,
                )
              : null,
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? primaryColor : Colors.black87,
                  ),
                ),
                Text(
                  nativeLabel,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: primaryColor, size: 22),
          ],
        ),
      ),
    );
  }
}
