import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';

class SignUpGenderSelector extends StatelessWidget {
  final String? selectedGender;
  final void Function(String?) onChanged;
  final String labelGender;
  final String labelFemale;
  final String labelMale;

  const SignUpGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
    required this.labelGender,
    required this.labelFemale,
    required this.labelMale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelGender,
          style: getMediumStyle(
            color: AppColors.black,
            fontSize: FontSize.s14,
            fontFamily: FontConstants.interFamily,
          ),
        ),
        const SizedBox(width: AppSize.s24),
        _GenderRadio(
          label: labelFemale,
          value: 'female',
          groupValue: selectedGender,
          onChanged: onChanged,
        ),
        const SizedBox(width: AppSize.s16),
        _GenderRadio(
          label: labelMale,
          value: 'male',
          groupValue: selectedGender,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _GenderRadio extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final void Function(String?) onChanged;

  const _GenderRadio({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(
            label,
            style: getRegularStyle(
              color: AppColors.black,
              fontSize: FontSize.s14,
              fontFamily: FontConstants.interFamily,
            ),
          ),
        ],
      ),
    );
  }
}
