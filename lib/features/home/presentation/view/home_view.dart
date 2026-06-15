
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/nav_helper.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(child: Text("Home View")),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}