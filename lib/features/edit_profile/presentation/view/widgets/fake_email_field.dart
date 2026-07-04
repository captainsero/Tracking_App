import 'package:flutter/material.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/features/edit_profile/presentation/view/widgets/custom_label_field.dart';

class FakeEmailField extends StatelessWidget {
  FakeEmailField({super.key});

  // controller محلي بس عشان الـ widget، مش متربط بأي Cubit
  final TextEditingController _fakeController = TextEditingController(
    text: 'emailexample@gmail.com',
  );

  @override
  Widget build(BuildContext context) {
    return CustomLabelField(
      label: S.of(context).email,
      controller: _fakeController,
      hint: 'emailexample@gmail.com',
      keyboardType: TextInputType.phone,
      readOnly: true,
    );
  }
}
