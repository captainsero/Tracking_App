import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/style_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../widgets/animated_bottom_waves.dart';

class SuccessApplyView extends StatelessWidget {
  const SuccessApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: Stack(
        children: [
          // Decorative background waves at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const AnimatedBottomWaves(),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Success animation
                    Transform.scale(
                      scale: 1.4,
                      child: Lottie.asset(
                        'assets/animations/tick_green.json',
                        // repeat: true,
                      ),
                    ),

                    const SizedBox(height: AppSize.s24),

                    // Title
                    Text(
                      "Your application has been submitted!",
                      textAlign: TextAlign.center,
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: FontSize.s22,
                        fontFamily: FontConstants.interFamily,
                      ),
                    ),

                    const SizedBox(height: AppSize.s12),

                    // Description
                    Text(
                      "Thank you for providing your application, we will review your application and will get back to you soon.",
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: AppColors.lightGrey,
                        fontSize: FontSize.s18,
                        fontFamily: FontConstants.interFamily,
                      ),
                    ),

                    const SizedBox(height: AppSize.s20),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: AppSize.s52,
                      child: ElevatedButton(
                        onPressed: () => context.go(RoutePath.login),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(RadiusSize.r100),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Login",
                          style: getSemiBoldStyle(
                            color: AppColors.white,
                            fontSize: FontSize.s16,
                            fontFamily: FontConstants.interFamily,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSize.s100)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}