import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:tracking_app/core/utills/image_picker_service.dart';
import 'sign_up_body.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/widgets/sign_up_phone_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _secondNameCtrl = TextEditingController();
  final _vehicleNumberCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _nidCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String _country = 'Egypt';
  String _vehicleType = 'Car';
  String? _gender;
  String? _vehicleLicensePath;
  String? _nidImagePath;

  static const List<String> _countries = [
    'Egypt',
    'Saudi Arabia',
    'UAE',
    'Jordan',
    'Kuwait',
  ];

  static const Map<String, String> _vehicleTypeMap = {
    'Car': '507f1f77bcf86cd799439011',
    'Motorcycle': '507f1f77bcf86cd799439012',
    'Bicycle': '507f1f77bcf86cd799439013',
    'Truck': '507f1f77bcf86cd799439014',
  };

  static const List<String> _vehicleTypes = [
    'Car',
    'Motorcycle',
    'Bicycle',
    'Truck',
  ];

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _secondNameCtrl.dispose();
    _vehicleNumberCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _nidCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickVehicleLicense() async {
    final path = await ImagePickerService.pickFromGallery();

    if (path != null) {
      setState(() {
        _vehicleLicensePath = path;
      });
    }
  }

  Future<void> _pickNidImage() async {
    final path = await ImagePickerService.pickFromGallery();

    if (path != null) {
      setState(() {
        _nidImagePath = path;
      });
    }
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (_gender == null) {
      _showSnackBar(
        context,
        S.of(context).fieldRequired,
        AppColors.error,
      );
      return;
    }

    if (_vehicleLicensePath == null || _nidImagePath == null) {
      _showSnackBar(
        context,
        S.of(context).uploadLicensePhoto,
        AppColors.error,
      );
      return;
    }

    final config =
        kCountryPhoneConfigs[_country] ??
            kCountryPhoneConfigs['Egypt']!;

    final fullPhone =
        '${config.dialCode}${_phoneCtrl.text.trim()}';

    final signUpEntity = SignUpEntity(
      country: _country,
      firstName: _firstNameCtrl.text.trim(),
      lastName: _secondNameCtrl.text.trim(),

      // Send vehicle type ID instead of label
      vehicleType: _vehicleTypeMap[_vehicleType]!,

      vehicleNumber: _vehicleNumberCtrl.text.trim(),
      vehicleLicensePath: _vehicleLicensePath!,
      email: _emailCtrl.text.trim(),
      phone: fullPhone,
      nid: _nidCtrl.text.trim(),
      nidImagePath: _nidImagePath!,
      password: _passwordCtrl.text.trim(),
      rePassword: _confirmCtrl.text.trim(),
      gender: _gender!,
    );

    context.read<SignUpCubit>().signUp(signUpEntity);
  }

  void _showSnackBar(
      BuildContext context,
      String message,
      Color color,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _onCountryChanged(String? value) {
    setState(() {
      _country = value ?? _country;
    });
  }

  void _onVehicleTypeChanged(String? value) {
    setState(() {
      _vehicleType = value ?? _vehicleType;
    });
  }

  void _onGenderChanged(String? value) {
    setState(() {
      _gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpCubit>(),
      child: SignUpBody(
        formKey: _formKey,
        firstNameCtrl: _firstNameCtrl,
        secondNameCtrl: _secondNameCtrl,
        vehicleNumberCtrl: _vehicleNumberCtrl,
        emailCtrl: _emailCtrl,
        phoneCtrl: _phoneCtrl,
        nidCtrl: _nidCtrl,
        passwordCtrl: _passwordCtrl,
        confirmCtrl: _confirmCtrl,
        selectedCountry: _country,
        countries: _countries,
        vehicleType: _vehicleType,
        vehicleTypes: _vehicleTypes,
        gender: _gender,
        vehicleLicenseName: _vehicleLicensePath?.split('/').last,
        nidImageName: _nidImagePath?.split('/').last,
        onCountryChanged: _onCountryChanged,
        onVehicleTypeChanged: _onVehicleTypeChanged,
        onGenderChanged: _onGenderChanged,
        onPickVehicleLicense: _pickVehicleLicense,
        onPickNidImage: _pickNidImage,
        onSubmit: _submit,
      ),
    );
  }
}