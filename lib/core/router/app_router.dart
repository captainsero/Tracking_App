import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/config/shared_models/map_extra.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view/forgot_password_view.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view/verify_reset_view.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/cubit/forgot_password_cubit.dart';
import 'package:tracking_app/features/auth/login/presentation/view/pages/login_page.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/view/sign_up_view.dart';
import 'package:tracking_app/features/error/error_screen.dart';
import 'package:tracking_app/features/home/presentation/view/home_view.dart';
import 'package:tracking_app/features/map/presentation/view/map_view.dart';
import 'package:tracking_app/features/map/presentation/view_model/map_view_model.dart';
import 'package:tracking_app/features/order_details/domain/entities/order_entity.dart';
import 'package:tracking_app/features/order_details/domain/entities/order_status.dart';
import 'package:tracking_app/features/order_details/presentation/view/order_details_view.dart';
import 'package:tracking_app/features/orders/presentaion/view/orders_view.dart';
import '../../features/auth/forget_password/presentation/view/reset_password_view.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/view/success_apply_view.dart';
import 'package:tracking_app/features/change_password/presentation/view/change_password_view.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:tracking_app/features/onboarding/presentation/view/onboarding_page.dart';
import 'package:tracking_app/features/profile/presentation/view/profile_view.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:tracking_app/features/splash/presentaion/view/splash_view.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.home,
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
      GoRoute(
        path: RoutePath.home,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt.get<HomeCubit>(),
          child: HomeView(),
        ),
      ),

      GoRoute(
        path: RoutePath.profile,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt.get<ProfileCubit>(),
          child: ProfileView(),
        ),
      ),
      GoRoute(
        path: RoutePath.changePassword,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt.get<ChangePasswordCubit>(),
          child: const ChangePasswordView(),
        ),
      ),
      GoRoute(
        path: RoutePath.orders,
        builder: (context, state) => OrdersView(),
      ),
      GoRoute(
        path: RoutePath.orderDetails,
        builder: (context, state) => OrderDetailsScreen(
          order: Order(
            id: '',
            status: OrderStatus.accepted,
            createdAt: DateTime.now(),
            pickupContact: ContactInfo(
              name: 'name',
              address: 'address',
              phoneNumber: '',
            ),
            userContact: ContactInfo(
              name: 'name',
              address: 'address',
              phoneNumber: '',
            ),
            items: [],
            paymentMethod: 'paymentMethod',
          ),
        ),
      ),
      GoRoute(
        path: RoutePath.onboarding,
        builder: (context, state) => OnBoardingPage(),
      ),
      GoRoute(
        path: RoutePath.successApply,
        builder: (context, state) => SuccessApplyView(),
      ),
      GoRoute(
        path: RoutePath.map,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt.get<MapCubit>(),
          child: MapView(mapExtra: state.extra as MapExtra),
        ),
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) {
      return ErrorScreen(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
