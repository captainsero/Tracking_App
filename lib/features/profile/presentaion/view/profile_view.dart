import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/nav_helper.dart';
import '../../../../core/router/route_path.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: InkWell(
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(8),
            ),

            child: const Text(
              "Edit Profile",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),

          onTap: () {
            context.go(RoutePath.profileEdit);
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
