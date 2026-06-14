
import 'package:tracking_app/core/constants/validators_constants.dart';
import 'package:tracking_app/generated/l10n.dart';

abstract class AppTextFieldValidator {
  // ✅ Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.current.emailIsRequired;
    }

    final email = value.trim();

    final emailRegex = RegExp(ValidatorsConstants.regExpValidateEmail);

    if (!emailRegex.hasMatch(email)) {
      return S.current.enterValidEmail;
    }

    return null;
  }

  // ✅ Password validation (matches backend regex)
  static String? validatePassword(String? value) {
    final passRegex = RegExp(ValidatorsConstants.regExpValidatePassword);
    if (value == null || !passRegex.hasMatch(value)) {
      return S.current.enterValidPassword;
    }
    return null;
  }

  // ✅ Confirm Password (equality check only)
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return S.current.confirmPassword;
    }
    if (value != password) {
      return S.current.paswordNotMatched;
    }
    return null;
  }

  // ✅ OTP validation (6 digits)
  static String? validateOtpCode(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.codeIsRequired;
    }
    if (value.length != 6) {
      return S.current.invalidCode;
    }
    return null;
  }

  // ✅ Egyptian phone (01[0125]xxxxxxxx)
  static String? validatePhone(String? value) {
    final phoneRegex = RegExp(ValidatorsConstants.regExpValidatePhone);
    if (value == null || !phoneRegex.hasMatch(value)) {
      return S.current.enterValidEgyptianPhoneNumber;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.length < 3) {
      return S.current.mustBeAtLeast3Characters;
    }
    if (!RegExp(ValidatorsConstants.regExpValidateName).hasMatch(value)) {
      return S.current.onlyLettersAllowed;
    }
    return null;
  }
}
