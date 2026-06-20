import 'package:tracking_app/core/errors/validation_error.dart';

String? validationMessage(ValidationError? error) {
  if (error == null) return null;

  switch (error) {
    case ValidationError.emailRequired:
      return 'Email is required';
    case ValidationError.invalidEmail:
      return 'Please enter a valid email';
    case ValidationError.invalidPassword:
      return 'Password must contain at least 8 characters, a letter and a number';
    case ValidationError.confirmPasswordRequired:
      return 'Please confirm your password';
    case ValidationError.passwordsDoNotMatch:
      return 'Passwords do not match';
    case ValidationError.otpRequired:
      return 'OTP code is required';
    case ValidationError.invalidOtp:
      return 'OTP must be 6 digits';
    case ValidationError.invalidEgyptianPhone:
      return 'Please enter a valid Egyptian phone number';
    case ValidationError.nameTooShort:
      return 'Name must be at least 3 characters';
    case ValidationError.nameOnlyLetters:
      return 'Name must contain letters only';
  }
}
