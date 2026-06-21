import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view/forget_password_view.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view/reset_password_view.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view/verification_code_view.dart';
import 'package:tracking_app/features/auth/login/presentation/view/pages/login_page.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/view/sign_up_view.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/view/success_apply_view.dart';
import 'package:tracking_app/features/error/error_screen.dart';
import 'package:tracking_app/features/home/presentation/view/home_view.dart';
import 'package:tracking_app/features/onboarding/presentation/view/onboarding_page.dart';
import 'package:tracking_app/features/orders/domain/entitty/order_entity.dart';
import 'package:tracking_app/features/orders/domain/entitty/order_status.dart';
import 'package:tracking_app/features/orders/presentaion/view/order_details_view.dart';
import 'package:tracking_app/features/profile/presentation/view/profile_view.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:tracking_app/features/splash/presentaion/view/splash_view.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.onboarding,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(path: RoutePath.login, builder: (context, state) => LoginPage()),
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
        builder: (context, state) => BlocProvider(
          create: (context) => getIt.get<ProfileCubit>(),
          child: ProfileView(),
        ),
      ),
      GoRoute(
        path: RoutePath.orders, // build with true order data
      ),
      GoRoute(
        path: RoutePath.onboarding,
        builder: (context, state) => OnBoardingPage(),
      ),
      GoRoute(
        path: RoutePath.successApply,
        builder: (context, state) => SuccessApplyView(),
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) {
      return ErrorScreen(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
