import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/router/route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.placeHolder,
    routes: [],
  );
}
