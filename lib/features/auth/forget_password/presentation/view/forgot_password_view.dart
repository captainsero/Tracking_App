import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/cubit/forgot_password_cubit.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/widgets/custom_button.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/widgets/text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key, required this.forgotPasswordCubit});
  final ForgotPasswordCubit forgotPasswordCubit;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailController = TextEditingController();
  String _email = '';
  String? _localEmailError;

  StreamSubscription<BaseState<ForgotPasswordResponseModel>>? _forgotSub;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<ForgotPasswordCubit>();
    _forgotSub = cubit.stream
        .map((state) => state.forgotPasswordState)
        .distinct()
        .listen(_handleForgotPasswordView);
  }

  void _handleForgotPasswordView(BaseState<ForgotPasswordResponseModel> state) {
    if (state.isLoading == true) return;

    if (state.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      return;
    }

    if (state.data != null) {
      context.push(RoutePath.verifyReset);
    }
  }

  @override
  void dispose() {
    _forgotSub?.cancel();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(),
        title: const Text('Password'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const Text(
                'Forget password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter your email associated to\nyour account',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grey, fontSize: 13),
              ),
              const SizedBox(height: 28),
              CustomTextField(
                label: 'Email',
                hint: 'Enter you email',
                controller: emailController,
                errorText: _localEmailError,
                onChanged: (value) => _email = value,
              ),
              const SizedBox(height: 24),
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                buildWhen: (previous, current) =>
                    previous.forgotPasswordState != current.forgotPasswordState,
                builder: (context, state) {
                  return CustomButton(
                    label: 'Confirm',
                    isLoading: state.forgotPasswordState.isLoading == true,
                    onPressed: () {
                      context.read<ForgotPasswordCubit>().forgotPassword(
                        ForgotPasswordRequest(email: _email),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
