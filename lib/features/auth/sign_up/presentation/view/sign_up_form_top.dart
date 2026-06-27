import 'package:flutter/material.dart';
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/core/errors/validation_error_localizer.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_dropdown.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_file_upload_field.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_header.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_text_field.dart';

class SignUpFormTop extends StatelessWidget {
  final TextEditingController firstNameCtrl;
  final TextEditingController secondNameCtrl;
  final TextEditingController vehicleNumberCtrl;
  final String selectedCountry;
  final List<String> countries;
  final String selectedVehicleType;
  final String? vehicleLicenseName;
  final List<String> vehicleTypes;
  final void Function(String?) onCountryChanged;
  final void Function(String?) onVehicleTypeChanged;
  final VoidCallback onPickVehicleLicense;

  const SignUpFormTop({
    super.key,
    required this.firstNameCtrl,
    required this.secondNameCtrl,
    required this.vehicleNumberCtrl,
    required this.selectedCountry,
    required this.countries,
    required this.selectedVehicleType,
    required this.vehicleLicenseName,
    required this.vehicleTypes,
    required this.onCountryChanged,
    required this.onVehicleTypeChanged,
    required this.onPickVehicleLicense,
  });

  // Egypt flag emoji map — extend as needed
  static const Map<String, String> _flags = {
    'Egypt': '🇪🇬',
    'Saudi Arabia': '🇸🇦',
    'UAE': '🇦🇪',
    'Jordan': '🇯🇴',
    'Kuwait': '🇰🇼',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    const gap = SizedBox(height: AppSize.s16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SignUpHeader(),
        const SizedBox(height: AppSize.s24),
        _buildCountryDropdown(l10n),
        gap,
        _buildFirstNameField(l10n),
        gap,
        _buildSecondNameField(l10n),
        gap,
        _buildVehicleTypeDropdown(l10n),
        gap,
        _buildVehicleNumberField(l10n),
        gap,
        _buildVehicleLicenseUpload(l10n),
      ],
    );
  }

  SignUpDropdown<String> _buildCountryDropdown(S l10n) {
    return SignUpDropdown<String>(
      label: l10n.country,
      value: selectedCountry,
      items: countries
          .map((c) => DropdownMenuItem(
        value: c,
        child: Row(
          children: [
            Text(_flags[c] ?? '🌍', style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(c),
          ],
        ),
      ))
          .toList(),
      onChanged: onCountryChanged,
    );
  }

  SignUpTextField _buildFirstNameField(S l10n) {
    return SignUpTextField(
      label: l10n.firstLegalName,
      hint: l10n.enterFirstLegalName,
      controller: firstNameCtrl,
      validator: (v) => AppTextFieldValidator.validateName(v)?.localize(l10n),
    );
  }

  SignUpTextField _buildSecondNameField(S l10n) {
    return SignUpTextField(
      label: l10n.secondLegalName,
      hint: l10n.enterSecondLegalName,
      controller: secondNameCtrl,
      validator: (v) => AppTextFieldValidator.validateName(v)?.localize(l10n),
    );
  }

  SignUpDropdown<String> _buildVehicleTypeDropdown(S l10n) {
    return SignUpDropdown<String>(
      label: l10n.vehicleType,
      value: selectedVehicleType,
      items: vehicleTypes
          .map((t) => DropdownMenuItem(value: t, child: Text(t)))
          .toList(),
      onChanged: onVehicleTypeChanged,
    );
  }

  SignUpTextField _buildVehicleNumberField(S l10n) {
    return SignUpTextField(
      label: l10n.vehicleNumber,
      hint: l10n.enterVehicleNumber,
      controller: vehicleNumberCtrl,
      validator: (v) =>
      (v == null || v.trim().isEmpty) ? l10n.vehicleNumberRequired : null,
    );
  }

  SignUpFileUploadField _buildVehicleLicenseUpload(S l10n) {
    return SignUpFileUploadField(
      label: l10n.vehicleLicense,
      hint: l10n.uploadLicensePhoto,
      fileName: vehicleLicenseName,
      onTap: onPickVehicleLicense,
    );
  }
}