import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/edit_profile_body.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';

class EditProfilePage extends StatelessWidget {
  /// Optional initial values to pre-populate the form fields.
  final String firstName;
  final String lastName;
  final String phone;
  final String email;

  const EditProfilePage({
    super.key,
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.email = '',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileCubit>()
        ..initFields(
          firstName: firstName,
          lastName: lastName,
          phone: phone, gender: '',
        ),
      child: const EditProfileBody(),
    );
  }
}
