import 'package:flutter/material.dart';
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
        Expanded(
          child: _GenderRadioOption(
            value: 'male',
            label: 'Male',
            icon: Icons.male_rounded,
            groupValue: selectedGender,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _GenderRadioOption(
            value: 'female',
            label: 'Female',
            icon: Icons.female_rounded,
            groupValue: selectedGender,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _GenderRadioOption extends StatelessWidget {
  const _GenderRadioOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.groupValue,
    required this.onChanged,
  });

  final String value;
  final String label;
  final IconData icon;
  final String? groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = groupValue == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.07)
              : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            // Radio button
            SizedBox(
              width: 20,
              height: 20,
              child: Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: (v) => onChanged(v!),
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 6),
            // Gender icon
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.primary : Colors.grey.shade500,
            ),
            const SizedBox(width: 4),
            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                  color:
                      isSelected ? AppColors.primary : Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}