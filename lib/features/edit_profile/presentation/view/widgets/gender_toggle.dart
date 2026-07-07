import 'package:flutter/material.dart';
import 'package:tracking_app/generated/l10n.dart';

class GenderToggle extends StatelessWidget {
  const GenderToggle({
    super.key,
    required this.selectedGender,
  });

  final String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).gender,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 50),
        _GenderRadioOption(
          value: 'male',
          label: S.of(context).male,
          groupValue: selectedGender,
        ),
        const SizedBox(width: 40),
        _GenderRadioOption(
          value: 'female',
          label: S.of(context).female,
          groupValue: selectedGender,
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
  });

  final String value;
  final String label;
  final String? groupValue;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = groupValue == value;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Radio<String>(
            value: value,
            groupValue: groupValue,
            // null onChanged makes the Radio non-interactive (read-only)
            onChanged: null,
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.primary;
              }
              return Theme.of(context).hintColor;
            }),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }
}
