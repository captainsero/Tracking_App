import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:tracking_app/features/auth/sign_up/presentation/view_model/sign_up_state.dart';
import 'sign_up_form_bottom.dart';
import 'sign_up_form_top.dart';

class SignUpBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl;
  final TextEditingController secondNameCtrl;
  final TextEditingController vehicleNumberCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController nidCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmCtrl;
  final String selectedCountry;
  final List<String> countries;
  final String vehicleType;
  final String? gender;
  final String? vehicleLicenseName;
  final String? nidImageName;
  final List<String> vehicleTypes;
  final void Function(String?) onCountryChanged;
  final void Function(String?) onVehicleTypeChanged;
  final void Function(String?) onGenderChanged;
  final VoidCallback onPickVehicleLicense;
  final VoidCallback onPickNidImage;
  final void Function(BuildContext) onSubmit;

  const SignUpBody({
    super.key,
    required this.formKey,
    required this.firstNameCtrl,
    required this.secondNameCtrl,
    required this.vehicleNumberCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.nidCtrl,
    required this.passwordCtrl,
    required this.confirmCtrl,
    required this.selectedCountry,
    required this.countries,
    required this.vehicleType,
    required this.gender,
    required this.vehicleLicenseName,
    required this.nidImageName,
    required this.vehicleTypes,
    required this.onCountryChanged,
    required this.onVehicleTypeChanged,
    required this.onGenderChanged,
    required this.onPickVehicleLicense,
    required this.onPickNidImage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: _handleStateChange,
      builder: (ctx, state) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(ctx, state),
      ),
    );
  }

  void _handleStateChange(BuildContext ctx, SignUpState state) {
    if (state.isSuccess) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(S.of(ctx).applySuccess),
        backgroundColor: AppColors.success,
      ));
      ctx.go(RoutePath.successApply);
    }
    if (state.isFailure && state.errorMessage != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(state.errorMessage!),
        backgroundColor: AppColors.error,
      ));
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => context.go(RoutePath.onboarding),
        child: Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.black, size: AppSize.s20),
      ),
      title: Text(
        S.of(context).apply,
        style: getMediumStyle(
          color: AppColors.black,
          fontSize: FontSize.s18,
          fontFamily: FontConstants.interFamily,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext ctx, SignUpState state) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p16,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormTop(),
              const SizedBox(height: AppSize.s16),
              _buildFormBottom(ctx, state),
            ],
          ),
        ),
      ),
    );
  }

  SignUpFormTop _buildFormTop() {
    return SignUpFormTop(
      firstNameCtrl: firstNameCtrl,
      secondNameCtrl: secondNameCtrl,
      vehicleNumberCtrl: vehicleNumberCtrl,
      selectedCountry: selectedCountry,
      countries: countries,
      selectedVehicleType: vehicleType,
      vehicleLicenseName: vehicleLicenseName,
      vehicleTypes: vehicleTypes,
      onCountryChanged: onCountryChanged,
      onVehicleTypeChanged: onVehicleTypeChanged,
      onPickVehicleLicense: onPickVehicleLicense,
    );
  }

  SignUpFormBottom _buildFormBottom(BuildContext ctx, SignUpState state) {
    return SignUpFormBottom(
      selectedCountry: selectedCountry,
      emailCtrl: emailCtrl,
      phoneCtrl: phoneCtrl,
      nidCtrl: nidCtrl,
      passwordCtrl: passwordCtrl,
      confirmPasswordCtrl: confirmCtrl,
      nidImageName: nidImageName,
      selectedGender: gender,
      isLoading: state.isLoading,
      onPickNidImage: onPickNidImage,
      onGenderChanged: onGenderChanged,
      onSubmit: () => onSubmit(ctx),
    );
  }
}