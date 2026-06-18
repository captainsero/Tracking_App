import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ← Added for input formatters
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/core/errors/validation_error_localizer.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_file_upload_field.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_gender_selector.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_password_row.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_phone_field.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_submit_button.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_text_field.dart';

class SignUpFormBottom extends StatelessWidget {
  final String selectedCountry;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController nidCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final String? nidImageName;
  final String? selectedGender;
  final bool isLoading;
  final VoidCallback onPickNidImage;
  final void Function(String?) onGenderChanged;
  final VoidCallback onSubmit;

  const SignUpFormBottom({
    super.key,
    required this.selectedCountry,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.nidCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.nidImageName,
    required this.selectedGender,
    required this.isLoading,
    required this.onPickNidImage,
    required this.onGenderChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    const gap = SizedBox(height: AppSize.s16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SignUpTextField(
          label: l10n.email,
          hint: l10n.enterEmail,
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          validator: (v) => AppTextFieldValidator.validateEmail(v)?.localize(l10n),
        ),
        gap,
        SignUpPhoneField(
          controller: phoneCtrl,
          selectedCountry: selectedCountry,
        ),
        gap,
        // Improved NID Field
        SignUpTextField(
          label: l10n.idNumber,
          hint: l10n.enterIdNumber,
          controller: nidCtrl,
          keyboardType: TextInputType.number,
          maxLength: 14,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (v) => AppTextFieldValidator.validateNid(v)?.localize(l10n),
        ),
        gap,
        SignUpFileUploadField(
          label: l10n.idImage,
          hint: l10n.uploadIdImage,
          fileName: nidImageName,
          onTap: onPickNidImage,
        ),
        gap,
        SignUpPasswordRow(
          passwordController: passwordCtrl,
          confirmController: confirmPasswordCtrl,
        ),
        const SizedBox(height: AppSize.s20),
        SignUpGenderSelector(
          selectedGender: selectedGender,
          labelGender: l10n.gender,
          labelFemale: l10n.female,
          labelMale: l10n.male,
          onChanged: onGenderChanged,
        ),
        const SizedBox(height: AppSize.s30),
        SignUpSubmitButton(isLoading: isLoading, onPressed: onSubmit),
        const SizedBox(height: AppSize.s20),
      ],
    );
  }
}