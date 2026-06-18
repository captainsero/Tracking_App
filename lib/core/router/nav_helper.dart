import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/router/route_path.dart';

class NavHelper {
  static int getCurrentIndex(String location) {
    if (location == RoutePath.home) return 0;
    if (location == RoutePath.orders) return 1;
    if (location == RoutePath.profile) return 2;
    return 0;
  }

  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RoutePath.home);
        break;
      case 1:
        context.go(RoutePath.orders);
        break;

      case 2:
        context.go(RoutePath.profile);
        break;
    }
  }
}
