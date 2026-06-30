import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? avatarUrl;

  const Avatar({super.key, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      imageProvider = avatarUrl!.startsWith('http')
          ? NetworkImage(avatarUrl!)
          : AssetImage(avatarUrl!) as ImageProvider;
    }

    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? Icon(Icons.person_rounded, color: Colors.grey.shade500, size: 30)
          : null,
    );
  }
}
