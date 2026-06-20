// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Request timed out. Please check your internet connection.`
  String get connectionTimeout {
    return Intl.message(
      'Request timed out. Please check your internet connection.',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Server error. Please try again later.`
  String get serverError {
    return Intl.message(
      'Server error. Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Requested resource not found.`
  String get notFound {
    return Intl.message(
      'Requested resource not found.',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get errorMessageGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'errorMessageGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your connection.`
  String get networkError {
    return Intl.message(
      'Network error. Please check your connection.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out. Please try again.`
  String get requestTimeout {
    return Intl.message(
      'Request timed out. Please try again.',
      name: 'requestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save information securely. Please try again.`
  String get secureStorageErrorMessage {
    return Intl.message(
      'Failed to save information securely. Please try again.',
      name: 'secureStorageErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `No value found for key: `
  String get noValueKeyFound {
    return Intl.message(
      'No value found for key: ',
      name: 'noValueKeyFound',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get paswordNotMatched {
    return Intl.message(
      'Passwords do not match',
      name: 'paswordNotMatched',
      desc: '',
      args: [],
    );
  }

  /// `Code is required`
  String get codeIsRequired {
    return Intl.message(
      'Code is required',
      name: 'codeIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalidCode {
    return Intl.message(
      'Invalid code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid Egyptian phone number`
  String get enterValidEgyptianPhoneNumber {
    return Intl.message(
      'Enter a valid Egyptian phone number',
      name: 'enterValidEgyptianPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 3 characters`
  String get mustBeAtLeast3Characters {
    return Intl.message(
      'Must be at least 3 characters',
      name: 'mustBeAtLeast3Characters',
      desc: '',
      args: [],
    );
  }

  /// `Only letters allowed`
  String get onlyLettersAllowed {
    return Intl.message(
      'Only letters allowed',
      name: 'onlyLettersAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get enterValidEmail {
    return Intl.message(
      'Enter a valid email address',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password needs uppercase, digit, and special char`
  String get enterValidPassword {
    return Intl.message(
      'Password needs uppercase, digit, and special char',
      name: 'enterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong.`
  String get oopsSomthingWentWrong {
    return Intl.message(
      'Oops! Something went wrong.',
      name: 'oopsSomthingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `goToHome`
  String get goToHome {
    return Intl.message(
      'goToHome',
      name: 'goToHome',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Elevate Tracking App`
  String get onBoardingWelcomeText {
    return Intl.message(
      'Welcome to Elevate Tracking App',
      name: 'onBoardingWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get onBoardingLogin {
    return Intl.message(
      'Login',
      name: 'onBoardingLogin',
      desc: '',
      args: [],
    );
  }

  /// `Apply Now`
  String get onBoardingApplyNow {
    return Intl.message(
      'Apply Now',
      name: 'onBoardingApplyNow',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!!`
  String get welcome {
    return Intl.message(
      'Welcome!!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `You want to be a delivery man?\nJoin our team`
  String get applySubtitle {
    return Intl.message(
      'You want to be a delivery man?\nJoin our team',
      name: 'applySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Application submitted successfully!`
  String get applySuccess {
    return Intl.message(
      'Application submitted successfully!',
      name: 'applySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get selectCountry {
    return Intl.message(
      'Select country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `First legal name`
  String get firstLegalName {
    return Intl.message(
      'First legal name',
      name: 'firstLegalName',
      desc: '',
      args: [],
    );
  }

  /// `Enter first legal name`
  String get enterFirstLegalName {
    return Intl.message(
      'Enter first legal name',
      name: 'enterFirstLegalName',
      desc: '',
      args: [],
    );
  }

  /// `Second legal name`
  String get secondLegalName {
    return Intl.message(
      'Second legal name',
      name: 'secondLegalName',
      desc: '',
      args: [],
    );
  }

  /// `Enter second legal name`
  String get enterSecondLegalName {
    return Intl.message(
      'Enter second legal name',
      name: 'enterSecondLegalName',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle type`
  String get vehicleType {
    return Intl.message(
      'Vehicle type',
      name: 'vehicleType',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle number`
  String get vehicleNumber {
    return Intl.message(
      'Vehicle number',
      name: 'vehicleNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter vehicle number`
  String get enterVehicleNumber {
    return Intl.message(
      'Enter vehicle number',
      name: 'enterVehicleNumber',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle number is required`
  String get vehicleNumberRequired {
    return Intl.message(
      'Vehicle number is required',
      name: 'vehicleNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle license`
  String get vehicleLicense {
    return Intl.message(
      'Vehicle license',
      name: 'vehicleLicense',
      desc: '',
      args: [],
    );
  }

  /// `Upload license photo`
  String get uploadLicensePhoto {
    return Intl.message(
      'Upload license photo',
      name: 'uploadLicensePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `ID number`
  String get idNumber {
    return Intl.message(
      'ID number',
      name: 'idNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter national ID number`
  String get enterIdNumber {
    return Intl.message(
      'Enter national ID number',
      name: 'enterIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `ID number is required`
  String get idNumberRequired {
    return Intl.message(
      'ID number is required',
      name: 'idNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid 14-digit ID number`
  String get invalidIdNumber {
    return Intl.message(
      'Enter a valid 14-digit ID number',
      name: 'invalidIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `ID image`
  String get idImage {
    return Intl.message(
      'ID image',
      name: 'idImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload ID image`
  String get uploadIdImage {
    return Intl.message(
      'Upload ID image',
      name: 'uploadIdImage',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `enterA`
  String get enterA {
    return Intl.message(
      'enterA',
      name: 'enterA',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Confirm logout!!`
  String get confirmLogout {
    return Intl.message(
      'Confirm logout!!',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
