import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/values_manager.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
        size: AppSize.s24,
      ),
    );
  }
}
