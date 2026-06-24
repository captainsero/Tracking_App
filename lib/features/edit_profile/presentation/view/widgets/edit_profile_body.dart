import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/login/presentation/view/widgets/Custom%20toast.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
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
                    child: _ProfileAvatar(
                      imagePath: state.selectedImagePath,
                      onTap: () =>
                          cubit.doIntent(EditProfileEvents.pickImageEvent()),
                    ),
                  ),
                  const SizedBox(height: 28),

            
                  // First & Last name row
                  Row(
                    children: [
                      Expanded(
                        child: _LabeledField(
                          label: 'First name',
                          child: _FieldBox(
                            icon: Icons.person_outline_rounded,
                            controller: cubit.firstNameController,
                            hint: 'First name',
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _LabeledField(
                          label: 'Last name',
                          child: _FieldBox(
                            icon: Icons.person_outline_rounded,
                            controller: cubit.lastNameController,
                            hint: 'Last name',
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // _LabeledField(
                  //   label: 'Email',
                  //   child: _FieldBox(
                  //     icon: Icons.mail_outline_rounded,
                  //     controller: cubit.emailController,
                  //     hint: 'Email address',
                  //     readOnly: true,
                  //   ),
                  // ),
                  // const SizedBox(height: 12),

                  _LabeledField(
                    label: 'Phone number',
                    child: _FieldBox(
                      icon: Icons.phone_outlined,
                      controller: cubit.phoneController,
                      hint: 'Phone number',
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  _LabeledField(
                    label: 'Password',
                    child: _PasswordFieldBox(
                      onChangeTap: () =>
                          context.push(RoutePath.forgetPassword),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Divider ──────────────────────────────────────────────
                  Divider(color: Colors.grey.shade200, thickness: 0.5),
                  const SizedBox(height: 20),

                  // // ── Gender ───────────────────────────────────────────────
                  // _SectionLabel('Gender'),
                  // const SizedBox(height: 10),
                  // _GenderToggle(
                  //   selectedGender: state.selectedGender,
                  //   onChanged: (g) =>
                  //       cubit.doIntent(EditProfileEvents.selectGenderEvent(g)),
                  // ),
                  // const SizedBox(height: 32),

                  // ── Save Button ──────────────────────────────────────────
                  _SaveButton(
                    isLoading: state.updateProfileState.isLoading == true,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.doIntent(EditProfileEvents.updateProfileEvent());
                      }
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

// ─────────────────────────── Sub-Widgets ────────────────────────────────────

/// Unchanged — kept exactly as original
class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.imagePath, required this.onTap});

  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightPink,
              border: Border.all(color: AppColors.primary, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: imagePath != null
                  ? Image.file(File(imagePath!), fit: BoxFit.cover)
                  : Icon(
                      Icons.person_rounded,
                      size: 56,
                      color: AppColors.primary,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _SectionLabel extends StatelessWidget {
//   const _SectionLabel(this.text);
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text.toUpperCase(),
//       style: TextStyle(
//         fontSize: 11,
//         fontWeight: FontWeight.w500,
//         color: Colors.grey.shade500,
//         letterSpacing: 0.6,
//         fontFamily: 'Inter',
//       ),
//     );
//   }
// }

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
          padding: const EdgeInsets.only(left: 2, bottom: 4),
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

class _FieldBox extends StatelessWidget {
  const _FieldBox({
    required this.icon,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.validator,
  }) : readOnly = false;

  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: validator,
      style: TextStyle(
        fontSize: 14,
        color: readOnly ? Colors.grey.shade500 : Colors.black87,
        fontFamily: 'Inter',
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary, size: 17),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 1.2),
        ),
      ),
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

class _GenderToggle extends StatelessWidget {
  const _GenderToggle({
    required this.selectedGender,
    required this.onChanged,
  });

  final String? selectedGender;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final isFemale = selectedGender == 'female';
    final isMale = selectedGender == 'male' || selectedGender == null;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged('female'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isFemale ? AppColors.primary : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.female_rounded,
                        size: 16,
                        color: isFemale ? Colors.white : Colors.grey.shade500,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color:
                              isFemale ? Colors.white : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(width: 0.5, color: Colors.grey.shade200),
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged('male'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isMale ? AppColors.primary : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.male_rounded,
                        size: 16,
                        color: isMale ? Colors.white : Colors.grey.shade500,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: isMale ? Colors.white : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
      ),
    );
  }
}

