
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/nav_helper.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: const Center(child: Text("Orders View")),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}