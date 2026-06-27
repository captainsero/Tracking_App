import 'package:tracking_app/config/di/di.dart';

import '../widgets/login_body.dart';
import '../../view_model/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: const LoginBody(),
      ),
    );
  }
}
