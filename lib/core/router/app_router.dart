import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/onboarding/presentation/view/onboarding_view.dart';
import '../../features/auth/forget_password/presentation/view/forget_password_view.dart';
import '../../features/auth/forget_password/presentation/view/reset_password_view.dart';
import '../../features/auth/forget_password/presentation/view/verification_code_view.dart';
import '../../features/auth/login/presentation/view/login_view.dart';
import '../../features/auth/sign_up/presentation/view/sign_up_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/orders/presentaion/view/orders_view.dart';
import '../../features/profile/presentaion/view/profile_view.dart';
import '../../features/splash/presentaion/view/splash_view.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.login,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(path: RoutePath.login, builder: (context, state) => LoginView()),
      GoRoute(
        path: RoutePath.signup,
        builder: (context, state) => SignUpView(),
      ),
      GoRoute(
        path: RoutePath.forgetPassword,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        path: RoutePath.verificationCodeView,
        builder: (context, state) => VerificationCodeView(),
      ),
      GoRoute(
        path: RoutePath.resetPassword,
        builder: (context, state) => ResetPasswordView(),
      ),
      GoRoute(path: RoutePath.home, builder: (context, state) => HomeView()),

      GoRoute(
        path: RoutePath.profile,
        builder: (context, state) => ProfileView(),
      ),
      GoRoute(
        path: RoutePath.orders,
        builder: (context, state) => OrdersView(),
      ),
      GoRoute(
        path: RoutePath.onboarding,
        builder: (context, state) => OnboardingView(),
      ),
    ],
  );
}
