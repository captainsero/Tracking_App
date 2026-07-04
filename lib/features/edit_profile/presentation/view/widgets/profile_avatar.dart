import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.imagePath, required this.onTap});

  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightPink,
              border: Border.all(color: AppColors.primary, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: imagePath != null
                  ? Image.file(File(imagePath!), fit: BoxFit.cover)
                  : Icon(
                      Icons.person_rounded,
                      size: 56,
                      color: AppColors.primary,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColors.white,
                  size: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}