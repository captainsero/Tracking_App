import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/router/route_path.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  // TODO: swap this for your app's actual primary/brand color constant.
  static const Color _signUpColor = Color(0xFFC2185B);

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
