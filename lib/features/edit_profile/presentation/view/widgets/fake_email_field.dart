import 'package:flutter/material.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/custom_label_field.dart';

import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FakeEmailField extends StatelessWidget {
  const FakeEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return CustomLabelField(
      label: S.of(context).email,
      controller: cubit.emailController,
      hint: 'emailexample@gmail.com',
      keyboardType: TextInputType.emailAddress,
      readOnly: true,
    );
  }
}
