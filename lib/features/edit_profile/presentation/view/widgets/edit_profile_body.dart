import 'package:flutter/material.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/login/presentation/view/widgets/Custom%20toast.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/custom_label_field.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/fake_email_field.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/gender_toggle.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/password_field_box.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/profile_avatar.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/save_button.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leadingWidth: 54,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                context.pop();
              } else {
                context.go(RoutePath.profile);
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
              size: 16,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: const CircleBorder(),
              side: BorderSide(color: AppColors.cardBorder, width: 0.8),
              minimumSize: const Size(36, 36),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        title: Text(
          S.of(context).Edit_Profile,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listenWhen: (previous, current) =>
            previous.updateProfileState != current.updateProfileState,
        listener: (context, state) {
          final updateState = state.updateProfileState;
          if (updateState.data != null) {
            CustomToast(
              context: context,
              header: 'Profile Updated Successfully',
              type: ToastificationType.success,
            ).showToast();
          } else if (updateState.errorMessage != null) {
            CustomToast(
              context: context,
              header: S.of(context).error,
              description: updateState.errorMessage,
              type: ToastificationType.error,
            ).showToast();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Avatar ──────────────────────────────────────────────
                  Center(
                    child: ProfileAvatar(
                      imagePath: state.selectedImagePath,
                      onTap: () =>
                          cubit.doIntent(EditProfileEvents.pickImageEvent()),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── First & Last name row ────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: CustomLabelField(
                          label: S.of(context).fistName,
                          controller: cubit.firstNameController,
                          // icon: Icons.person_outline_rounded,
                          hint: S.of(context).fistName,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomLabelField(
                          label: S.of(context).lastName,
                          controller: cubit.lastNameController,
                          // icon: Icons.person_outline_rounded,
                          hint: S.of(context).lastName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Phone number ─────────────────────────────────────────
                  CustomLabelField(
                    label: S.of(context).phoneNumber,
                    controller: cubit.phoneController,
                    // icon: Icons.phone_outlined,
                    hint: S.of(context).phoneNumber,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // ── Email ─────────────────────────────────────────
                  FakeEmailField(),
                  const SizedBox(height: 16),

                  // ── Password ─────────────────────────────────────────────
                  PasswordFieldBox(
                    onChangeTap: () => context.push(RoutePath.forgetPassword),
                  ),
                  const SizedBox(height: 16),

                  // ── Gender ───────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GenderToggle(
                      selectedGender: state.selectedGender,
                      onChanged: cubit.selectGender,
                    ),
                  ),
                  const SizedBox(height: 34),

                  // ── Save Button ──────────────────────────────────────────
                  SaveButton(
                    isLoading: state.updateProfileState.isLoading == true,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      cubit.doIntent(EditProfileEvents.updateProfileEvent());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
