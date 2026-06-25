import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

class GenderToggle extends StatelessWidget {
  const GenderToggle({required this.selectedGender, required this.onChanged});

  final String? selectedGender;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final isFemale = selectedGender == 'female';
    final isMale = selectedGender == 'male' || selectedGender == null;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged('female'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isFemale ? AppColors.primary : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.female_rounded,
                        size: 16,
                        color: isFemale ? Colors.white : Colors.grey.shade500,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: isFemale ? Colors.white : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(width: 0.5, color: Colors.grey.shade200),
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged('male'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isMale ? AppColors.primary : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.male_rounded,
                        size: 16,
                        color: isMale ? Colors.white : Colors.grey.shade500,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: isMale ? Colors.white : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}