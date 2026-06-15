import 'package:flutter/material.dart';

class VerificationCodeView extends StatefulWidget {
  const VerificationCodeView({super.key});

  @override
  State<VerificationCodeView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<VerificationCodeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Email Verification")));
  }
}