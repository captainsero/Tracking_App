import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
          GestureDetector(
            onTap: () {
              // TODO: navigate to the sign-up screen, e.g.
              // context.go(Routes.signUp)
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 14.sp,
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