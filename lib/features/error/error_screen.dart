import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/generated/l10n.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(S.current.error), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: AppSize.s100,
              ),
              const SizedBox(height: AppSize.s24),

              Text(
                S.current.oopsSomthingWentWrong,
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s16),

              Text(
                errorMessage,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO:change this to home Screen
                    context.go(RoutePath.placeHolder);
                  },
                  child: Text(S.current.goToHome),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
