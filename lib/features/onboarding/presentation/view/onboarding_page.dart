import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/core/shared_widgets/custom_button.dart';
import 'package:tracking_app/core/theme/app_typography.dart';
import 'package:tracking_app/generated/l10n.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.5,
              child: Lottie.asset('assets/animations/motorcycle.json'),
            ),
            SizedBox(height: 24),
            Text(
              S.of(context).onBoardingWelcomeText,
              style: 20.medium,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 24),
            CustomButton(
              onPressed: () {
                context.push(RoutePath.login);
              },
              title: S.of(context).onBoardingLogin,
            ),
            SizedBox(height: 16),
            CustomButton(
              backGroundColor: Colors.white,
              borderColor: Colors.black,
              titleStyle: 16.medium.copyWith(color: Colors.black),
              onPressed: () {
                context.push(RoutePath.signup);
              },
              title: S.of(context).onBoardingApplyNow,
            ),
          ],
        ),
      ),
    );
  }
}
