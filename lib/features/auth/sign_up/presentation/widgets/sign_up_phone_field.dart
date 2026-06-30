import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/generated/l10n.dart';

class CountryPhoneConfig {
  final String dialCode;
  final String flag;
  final int length;
  final String hint;
  final RegExp pattern;

  CountryPhoneConfig({
    required this.dialCode,
    required this.flag,
    required this.length,
    required this.hint,
    required String patternStr,
  }) : pattern = RegExp(patternStr);
}

final Map<String, CountryPhoneConfig> kCountryPhoneConfigs = {
  'Egypt': CountryPhoneConfig(
    dialCode: '+20',
    flag: '🇪🇬',
    length: 11,
    hint: '01XXXXXXXXX',
    patternStr: r'^01[0125]\d{8}$',
  ),
  'Saudi Arabia': CountryPhoneConfig(
    dialCode: '+966',
    flag: '🇸🇦',
    length: 10,
    hint: '05XXXXXXXX',
    patternStr: r'^05\d{8}$',
  ),
  'UAE': CountryPhoneConfig(
    dialCode: '+971',
    flag: '🇦🇪',
    length: 9,
    hint: '05XXXXXXX',
    patternStr: r'^05\d{7}$',
  ),
  'Jordan': CountryPhoneConfig(
    dialCode: '+962',
    flag: '🇯🇴',
    length: 10,
    hint: '07XXXXXXXX',
    patternStr: r'^07\d{8}$',
  ),
  'Kuwait': CountryPhoneConfig(
    dialCode: '+965',
    flag: '🇰🇼',
    length: 8,
    hint: 'XXXXXXXX',
    patternStr: r'^\d{8}$',
  ),
};

class SignUpPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String selectedCountry;

  const SignUpPhoneField({
    super.key,
    required this.controller,
    required this.selectedCountry,
  });

  @override
  State<SignUpPhoneField> createState() => _SignUpPhoneFieldState();
}

class _SignUpPhoneFieldState extends State<SignUpPhoneField> {
  OutlineInputBorder _border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: BorderSide(color: color, width: width),
      );

  CountryPhoneConfig get _config =>
      kCountryPhoneConfigs[widget.selectedCountry] ??
      kCountryPhoneConfigs['Egypt']!;

  String? _validate(String? value) {
    final l10n = S.current;
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.fieldRequired;
    }
    if (!_config.pattern.hasMatch(trimmed)) {
      return '${l10n.enterA} ${_config.hint} ${l10n.phoneNumber}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final config = _config;
    return TextFormField(
      controller: widget.controller,
      validator: _validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      maxLength: config.length,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: getRegularStyle(
        color: AppColors.black,
        fontSize: FontSize.s16,
        fontFamily: FontConstants.interFamily,
      ),
      decoration: InputDecoration(
        labelText: S.of(context).phoneNumber,
        hintText: config.hint,
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: getMediumStyle(
          color: AppColors.hintColor,
          fontSize: FontSize.s14,
          fontFamily: FontConstants.interFamily,
        ),
        hintStyle: getRegularStyle(
          color: AppColors.hintColor,
          fontSize: FontSize.s16,
          fontFamily: FontConstants.interFamily,
        ),
        errorStyle: getRegularStyle(
          color: AppColors.error,
          fontSize: FontSize.s12,
          fontFamily: FontConstants.interFamily,
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppPadding.p12,
            vertical: AppPadding.p8,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          decoration: BoxDecoration(
            color: AppColors.hintColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSize.s6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(config.flag, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: AppSize.s4),
              Text(
                config.dialCode,
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: FontSize.s14,
                  fontFamily: FontConstants.interFamily,
                ),
              ),
            ],
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p16,
        ),
        border: _border(AppColors.hintColor.withValues(alpha: 0.4)),
        enabledBorder: _border(AppColors.hintColor.withValues(alpha: 0.4)),
        focusedBorder: _border(AppColors.primary, width: AppSize.s1_5),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, width: AppSize.s1_5),
      ),
    );
  }
}
