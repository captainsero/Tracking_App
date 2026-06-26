import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/login/presentation/view/widgets/Custom%20toast.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/custom_label_field.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/gender_toggle.dart';
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5F5F5),
                border: Border.all(color: Colors.grey.shade200, width: 0.5),
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.black87,
                size: 22,
              ),
            ),
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
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
              header: 'Error',
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
                          label: 'First name',
                          controller: cubit.firstNameController,
                          // icon: Icons.person_outline_rounded,
                          hint: 'First name',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomLabelField(
                          label: 'Last name',
                          controller: cubit.lastNameController,
                          // icon: Icons.person_outline_rounded,
                          hint: 'Last name',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Phone number ─────────────────────────────────────────
                  CustomLabelField(
                    label: 'Phone number',
                    controller: cubit.phoneController,
                    // icon: Icons.phone_outlined,
                    hint: 'Phone number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // ── Gender ───────────────────────────────────────────────
                  GenderToggle(
                    selectedGender: state.selectedGender,
                    onChanged: cubit.selectGender,
                  ),
                  const SizedBox(height: 16),

                  // ── Password ─────────────────────────────────────────────
                  _PasswordFieldBox(
                    onChangeTap: () => context.push(RoutePath.forgetPassword),
                  ),
                  const SizedBox(height: 24),

                  // ── Divider ──────────────────────────────────────────────
                  Divider(color: Colors.grey.shade200, thickness: 0.5),
                  const SizedBox(height: 20),

                  // ── Save Button ──────────────────────────────────────────
                  SaveButton(
                    isLoading: state.updateProfileState.isLoading == true,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      cubit.doIntent(EditProfileEvents.updateProfileEvent());
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 6),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
              fontFamily: 'Inter',
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _PasswordFieldBox extends StatelessWidget {
  const _PasswordFieldBox({required this.onChangeTap});
  final VoidCallback onChangeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 17),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '••••••••',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                letterSpacing: 2,
              ),
            ),
          ),
          GestureDetector(
            onTap: onChangeTap,
            child: Text(
              'Change',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
