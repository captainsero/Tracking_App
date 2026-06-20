import 'package:flutter/material.dart';

class LoginOptionsRow extends StatefulWidget {
  const LoginOptionsRow({super.key});

  @override
  State<LoginOptionsRow> createState() => _LoginOptionsRowState();
}

class _LoginOptionsRowState extends State<LoginOptionsRow> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: _rememberMe,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: const BorderSide(color: Colors.grey),
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                  // TODO: wire this up to LoginCubit if "remember me" needs
                  // to be persisted/sent with the login request
                },
              ),
            ),
            SizedBox(width: 8),
            Text('Remember me', style: TextStyle(fontSize: 14)),
          ],
        ),
        GestureDetector(
          onTap: () {
            // TODO: navigate to the forgot-password screen, e.g.
            // context.go(Routes.forgetPassword)
          },
          child: Text(
            'Forget password?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
