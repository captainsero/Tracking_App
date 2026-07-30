import 'package:flutter/material.dart';
import 'package:tracking_app/features/profile/presentation/widgets/avatar.dart';
import 'package:tracking_app/features/profile/presentation/widgets/infocard.dart';

class ProfileCard extends StatelessWidget {
  final dynamic data;

  const ProfileCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final String? avatarUrl = data.photo.isNotEmpty ? data.photo : null;

    return InfoCard(
      onTap: () {
        // TODO: navigate to edit-profile screen.
      },
      child: Row(
        children: [
          Avatar(avatarUrl: avatarUrl),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.fullName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.email,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 2),
                Text(
                  data.phone,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
