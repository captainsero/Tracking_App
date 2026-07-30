import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? backGroundColor;
  final Color? borderColor;
  final TextStyle? titleStyle;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backGroundColor,
    this.borderColor,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: titleStyle,
      ),
    );
  }
}
