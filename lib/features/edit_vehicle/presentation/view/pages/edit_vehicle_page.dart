import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/features/edit_vehicle/presentation/view_model/cubit/edit_vehicle_cubit.dart';
import 'package:tracking_app/features/edit_vehicle/presentation/view/widgets/edit_vehicle_body.dart';

class EditVehiclePage extends StatelessWidget {
  final String? initialVehicleType;
  final String? initialVehicleNumber;
  final String? initialVehicleLicense;

  const EditVehiclePage({
    super.key,
    this.initialVehicleType,
    this.initialVehicleNumber,
    this.initialVehicleLicense,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<EditVehicleCubit>()
        ..initFields(
          vehicleType: initialVehicleType ?? '',
          vehicleNumber: initialVehicleNumber ?? '',
          vehicleLicense: initialVehicleLicense ?? '',
        ),
      child: const EditVehicleBody(),
    );
  }
}
