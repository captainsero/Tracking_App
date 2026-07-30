// ── Avatar ────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? avatarUrl;

  const Avatar({this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null
            ? Icon(Icons.person_rounded, color: Colors.grey.shade500, size: 30)
            : null,
      ),
    );
  }
}