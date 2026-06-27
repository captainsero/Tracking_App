import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/features/auth/login/presentation/view/widgets/Custom button.dart';
import 'package:tracking_app/features/auth/login/presentation/view/widgets/Custom toast.dart';
import 'package:tracking_app/features/edit_vehicle/presentation/view_model/cubit/edit_vehicle_cubit.dart';
import 'package:tracking_app/features/edit_vehicle/presentation/view_model/cubit/edit_vehicle_events.dart';
import 'package:tracking_app/features/edit_vehicle/presentation/view_model/cubit/edit_vehicle_states.dart';
import 'package:tracking_app/generated/l10n.dart';

class EditVehicleBody extends StatefulWidget {
  const EditVehicleBody({super.key});

  @override
  State<EditVehicleBody> createState() => _EditVehicleBodyState();
}

class _EditVehicleBodyState extends State<EditVehicleBody> {
  final List<String> _vehicleTypes = ['Car', 'Motorcycle', 'Bicycle', 'Truck'];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditVehicleCubit>();
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.editVehicle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // ── Vehicle Type Dropdown ───────────────────────────
                DropdownButtonFormField<String>(
                  value:
                      _vehicleTypes.contains(cubit.vehicleTypeController.text)
                      ? cubit.vehicleTypeController.text
                      : _vehicleTypes.first,
                  decoration: InputDecoration(
                    labelText: l10n.vehicleType,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  items: _vehicleTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        cubit.vehicleTypeController.text = value;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.fieldRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // ── Vehicle Number Field ────────────────────────────
                TextFormField(
                  controller: cubit.vehicleNumberController,
                  decoration: InputDecoration(
                    labelText: l10n.vehicleNumber,
                    hintText: l10n.enterVehicleNumber,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.vehicleNumberRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // ── Vehicle License Field ───────────────────────────
                TextFormField(
                  controller: cubit.vehicleLicenseController,
                  decoration: InputDecoration(
                    labelText: l10n.vehicleLicense,
                    hintText: l10n.vehicleLicense,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.download),
                      color: Colors.green,
                      onPressed: () {
                        // TODO: Implement download functionality for vehicle license pdf not image
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.fieldRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),

                // ── Save Button with State Handling ──────────────────
                BlocConsumer<EditVehicleCubit, EditVehicleStates>(
                  listenWhen: (previous, current) =>
                      previous.updateVehicleState != current.updateVehicleState,
                  listener: (context, state) {
                    final updateState = state.updateVehicleState;

                    if (updateState.data != null) {
                      CustomToast(
                        context: context,
                        header: 'Success',
                        description: updateState.data!.message,
                        type: ToastificationType.success,
                      ).showToast();
                      Navigator.of(context).pop();
                    } else if (updateState.errorMessage != null) {
                      CustomToast(
                        context: context,
                        header: l10n.error,
                        description: updateState.errorMessage,
                        type: ToastificationType.error,
                      ).showToast();
                    }
                  },
                  builder: (context, state) {
                    final isLoading =
                        state.updateVehicleState.isLoading == true;

                    return CustomButton(
                      title: l10n.saveChanges,
                      isLoading: isLoading,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.doIntent(
                            EditVehicleEvents.updateVehicleEvent(),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
