import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
        onPressed: () => context.pop(),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      actions: const [Icon(Icons.notifications_outlined, size: 26)],
    );
  }
}
