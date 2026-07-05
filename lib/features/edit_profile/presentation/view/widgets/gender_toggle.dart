import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

class GenderToggle extends StatelessWidget {
  const GenderToggle({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  final String? selectedGender;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).gender,
          style: TextStyle(
            fontSize: 14,
            fontFamily: FontConstants.interFamily,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        const SizedBox(width: 50),
        _GenderRadioOption(
          value: 'male',
          label: S.of(context).male,
          groupValue: selectedGender,
          onChanged: onChanged,
        ),
        const SizedBox(width: 40),
        _GenderRadioOption(
          value: 'female',
          label: S.of(context).female,
          groupValue: selectedGender,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _GenderRadioOption extends StatelessWidget {
  const _GenderRadioOption({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.onChanged,
  });

  final String value;
  final String label;
  final String? groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = groupValue == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: (v) => onChanged(v!),
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primary;
                }
                return AppColors.unSelectedIconColor;
              }),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontFamily: FontConstants.interFamily,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? AppColors.primary : AppColors.unSelectedIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
