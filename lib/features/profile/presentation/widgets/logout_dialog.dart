import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_state.dart';
import 'package:tracking_app/generated/l10n.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.logoutState.errorMessage != null) {
          context.pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.logoutState.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
        }

        if (state.logoutState.data != null) {
          context.go(RoutePath.login);
        }
      },
      listenWhen: (previous, current) =>
          previous.logoutState != current.logoutState,
      buildWhen: (previous, current) =>
          previous.logoutState != current.logoutState,
      builder: (context, state) {
        final isLoading = state.logoutState.isLoading == true;

        return AlertDialog(
          title: Text(S.current.logout, textAlign: TextAlign.center),
          content: Text(S.current.confirmLogout, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                side: BorderSide(
                  color:
                      Theme.of(context).textTheme.bodyLarge!.color ??
                      AppColors.grey,
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () {
                      Navigator.pop(context);
                    },
              child: Text(
                S.current.cancel,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

            SizedBox(width: AppSize.s10),

            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<ProfileCubit>().onEvent(LogoutEvent());
                    },

              child: isLoading
                  ? SizedBox(
                      width: AppSize.s20,
                      height: AppSize.s20,
                      child: CircularProgressIndicator(strokeWidth: AppSize.s2),
                    )
                  : Text(
                      S.current.logout,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
