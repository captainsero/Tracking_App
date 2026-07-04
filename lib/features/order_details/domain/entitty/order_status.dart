/// Mirrors the backend's order lifecycle. Keep this in sync with whatever
/// string values Firebase/your API actually sends — adjust [fromString]
/// if the backend uses different keys (e.g. "accepted" vs "ACCEPTED").
enum OrderStatus {
  pending,
  accepted,
  pickedUp,
  onTheWay,
  arrivedAtPickup,
  delivered,
  cancelled;

  static OrderStatus fromString(String raw) {
    switch (raw.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'accepted':
        return OrderStatus.accepted;
      case 'picked_up':
      case 'pickedup':
        return OrderStatus.pickedUp;
      case 'on_the_way':
      case 'ontheway':
        return OrderStatus.onTheWay;
      case 'arrived_at_pickup':
      case 'arrivedatpickup':
        return OrderStatus.arrivedAtPickup;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
      case 'canceled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  String get toRemoteValue {
    switch (this) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.accepted:
        return 'accepted';
      case OrderStatus.pickedUp:
        return 'picked_up';
      case OrderStatus.onTheWay:
        return 'on_the_way';
      case OrderStatus.arrivedAtPickup:
        return 'arrived_at_pickup';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.cancelled:
        return 'cancelled';
    }
  }

  /// Human label, e.g. "Accepted". Swap for localization (`.tr()`) later.
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.accepted:
        return 'Accepted';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      case OrderStatus.onTheWay:
        return 'On The Way';
      case OrderStatus.arrivedAtPickup:
        return 'Arrived at Pickup';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// 0-based index into the 5-segment stepper. Cancelled has no fixed slot.
  int get stepIndex {
    switch (this) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.accepted:
        return 1;
      case OrderStatus.pickedUp:
        return 2;
      case OrderStatus.onTheWay:
        return 3;
      case OrderStatus.arrivedAtPickup:
      case OrderStatus.delivered:
        return 4;
      case OrderStatus.cancelled:
        return 0;
    }
  }

  /// Label for the primary CTA button, given the *current* status.
  /// Returns null when there's no next action (e.g. already delivered).
  String? get nextActionLabel {
    switch (this) {
      case OrderStatus.pending:
        return 'Accept Order';
      case OrderStatus.accepted:
        return 'Picked Up';
      case OrderStatus.pickedUp:
        return 'On The Way';
      case OrderStatus.onTheWay:
        return 'Arrived at Pickup Point';
      case OrderStatus.arrivedAtPickup:
        return 'Mark as Delivered';
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return null;
    }
  }

  /// The status this order moves to once the CTA is pressed.
  OrderStatus? get next {
    switch (this) {
      case OrderStatus.pending:
        return OrderStatus.accepted;
      case OrderStatus.accepted:
        return OrderStatus.pickedUp;
      case OrderStatus.pickedUp:
        return OrderStatus.onTheWay;
      case OrderStatus.onTheWay:
        return OrderStatus.arrivedAtPickup;
      case OrderStatus.arrivedAtPickup:
        return OrderStatus.delivered;
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return null;
    }
  }
}
