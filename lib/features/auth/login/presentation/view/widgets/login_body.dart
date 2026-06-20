import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tracking_app/features/auth/login/presentation/view/widgets/Custom%20button.dart';
import 'package:tracking_app/features/auth/login/presentation/view/widgets/Custom%20toast.dart';
import 'package:tracking_app/generated/l10n.dart';

import 'do_not_have_account.dart';
import 'login_options_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/cubit/login_cubit.dart';
import '../../view_model/cubit/login_events.dart';
import '../../view_model/cubit/login_states.dart';
import 'login_textfields.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      // TODO: no localization key was provided for the screen title, so it's
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginTextfields(),
                SizedBox(height: 8.h),

                const LoginOptionsRow(),
                SizedBox(height: 50.h),

                BlocConsumer<LoginCubit, LoginStates>(
                  listenWhen: (previous, current) {
                    return previous.loginState != current.loginState;
                  },
                  listener: (context, states) {
                    final loginState = states.loginState;
                    if (loginState.data != null) {
                      // TODO: no "success" key was provided, hardcoded for now.
                      CustomToast(
                        context: context,
                        header: 'Success',
                        type: ToastificationType.success,
                      ).showToast();

                      // context.go(Routes.appLayout);
                    } else if (loginState.errorMessage != null) {
                      // TODO: no specific "invalid email or password" key was
                      // provided, so the generic error message is used here.
                      CustomToast(
                        context: context,
                        header: S.of(context).error,
                        description: S.of(context).errorMessageGeneric,
                        type: ToastificationType.error,
                      ).showToast();
                    }
                  },
                  builder: (context, states) {
                    final isLoading = states.loginState.isLoading == true;

                    return CustomButton(
                      // TODO: no localization key was provided for the button
                      // label, so it's hardcoded here.
                      title: 'Login',
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              if (cubit.formKey.currentState!.validate() ==
                                  false) {
                                return;
                              }
                              cubit.doIntent(LoginEvents.loginUserEvent());
                            },
                    );
                  },
                ),
                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: hook up actual "continue as guest" behaviour,
                      // e.g. cubit.doIntent(LoginEvents.continueAsGuestEvent())
                      // or context.go(Routes.appLayout) directly.
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      'Continue as guest',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  child: const DoNotHaveAccount(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
