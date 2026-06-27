sealed class EditVehicleEvents {
  const EditVehicleEvents();

  factory EditVehicleEvents.updateVehicleEvent() = UpdateVehicleEvent;

  void when({
    required Function() updateVehicleEvent,
  }) {
    if (this is UpdateVehicleEvent) {
      updateVehicleEvent();
    }
  }
}

class UpdateVehicleEvent extends EditVehicleEvents {}
