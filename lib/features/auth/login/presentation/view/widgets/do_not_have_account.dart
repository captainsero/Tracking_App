import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';

class DoNotHaveAccount extends StatelessWidget {
  DoNotHaveAccount({super.key});

  final Color _signUpColor = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          GestureDetector(
            onTap: () {
              context.go(RoutePath.signup);
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 14,
                color: _signUpColor,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: _signUpColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
