import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view/forgot_password_view.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view/verify_reset_view.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/cubit/forgot_password_cubit.dart';
import 'package:tracking_app/features/error/error_screen.dart';
import 'package:tracking_app/features/onboarding/presentation/view/onboarding_view.dart';
import '../../features/auth/forget_password/presentation/view/reset_password_view.dart';
import '../../features/auth/login/presentation/view/login_view.dart';
import '../../features/auth/sign_up/presentation/view/sign_up_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/orders/presentaion/view/orders_view.dart';
import '../../features/profile/presentaion/view/profile_view.dart';
import '../../features/splash/presentaion/view/splash_view.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.forgetPassword,
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
        builder: (context, state) {
          final forgotPasswordCubit = getIt.get<ForgotPasswordCubit>();

          return BlocProvider.value(
            value: getIt.get<ForgotPasswordCubit>(),

            child: ForgotPasswordView(forgotPasswordCubit: forgotPasswordCubit),
          );
        },
      ),
      GoRoute(
        path: RoutePath.verifyReset,
        builder: (context, state) {
          final ForgotPasswordCubit forgotPasswordCubit =
              state.extra as ForgotPasswordCubit;
          return BlocProvider.value(
            value: forgotPasswordCubit,
            child: VerifyResetView(forgotPasswordCubit: forgotPasswordCubit),
          );
        },
      ),
      GoRoute(
        path: RoutePath.resetPassword,
        builder: (context, state) {
          final ForgotPasswordCubit forgotPasswordCubit =
              state.extra as ForgotPasswordCubit;
          return BlocProvider.value(
            value: forgotPasswordCubit,
            child: ResetPasswordView(forgotPasswordCubit: forgotPasswordCubit),
          );
        },
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
    errorBuilder: (BuildContext context, GoRouterState state) {
      return ErrorScreen(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
