import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tracking_app/features/order_details/domain/entities/order_status.dart';

/// Writes real-time driver/order tracking updates to Firestore, at
/// `orders/{orderId}`, for the Florista app to stream and show on its
/// "track order" screen.
///
/// This mirrors the schema documented on Florista's side
/// (`OrderTrackingSnapshot.fromSnapshot`):
///   driverStatus      (String)    — one of DriverStatus.name
///   driverName        (String?)
///   driverPhone       (String?)
///   driverAvatarUrl   (String?)
///   arrivedAtPickupAt (Timestamp)
///   startDeliverAt    (Timestamp)
///   arrivedToUserAt   (Timestamp)
///   deliveredAt       (Timestamp)
///
/// Uses `SetOptions(merge: true)` so writing one field never clobbers
/// fields written by a previous step (or the shippingAddress the order
/// already had).
class OrderTrackingFirestoreDataSource {
  OrderTrackingFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  /// Pushes the driver's progress for [orderId] into Firestore.
  ///
  /// [status] is the tracking app's own [OrderStatus]. Its 4 granular
  /// delivery actions map onto Florista's 4-step [DriverStatus] timeline
  /// by POSITION in the flow, not by name — the two apps named their
  /// steps differently:
  ///
  ///   tracking app          Florista's DriverStatus   Florista timeline step
  ///   ─────────────         ───────────────────────   ──────────────────────
  ///   pickedUp        →     arrivedAtPickup            "Received your order"
  ///   onTheWay         →     startDeliver               "Preparing your order"
  ///   arrivedAtPickup  →     arrivedToUser              "Out for delivery"
  ///   delivered        →     delivered                  "Delivered"
  ///
  /// (Tracking's "arrivedAtPickup" here means "arrived at the recipient's
  /// address" — the pickup-from-shop step already happened at pickedUp.)
  Future<void> pushStatusUpdate({
    required String orderId,
    required OrderStatus status,
    String? driverName,
    String? driverPhone,
    String? driverAvatarUrl,
  }) async {
    final now = Timestamp.now();
    final data = <String, dynamic>{
      if (driverName != null) 'driverName': driverName,
      if (driverPhone != null) 'driverPhone': driverPhone,
      if (driverAvatarUrl != null) 'driverAvatarUrl': driverAvatarUrl,
    };

    switch (status) {
      case OrderStatus.pickedUp:
        data['driverStatus'] = 'arrivedAtPickup';
        data['arrivedAtPickupAt'] = now;
      case OrderStatus.onTheWay:
        data['driverStatus'] = 'startDeliver';
        data['startDeliverAt'] = now;
      case OrderStatus.arrivedAtPickup:
        data['driverStatus'] = 'arrivedToUser';
        data['arrivedToUserAt'] = now;
      case OrderStatus.delivered:
        data['driverStatus'] = 'delivered';
        data['deliveredAt'] = now;
      case OrderStatus.pending:
      case OrderStatus.accepted:
      case OrderStatus.cancelled:
        // Precedes Florista's granular timeline — no driverStatus field
        // yet, but the driver's identity can already be published once
        // assigned (accepted).
        break;
    }

    if (data.isEmpty) return;

    await _firestore
        .collection('orders')
        .doc(orderId)
        .set(data, SetOptions(merge: true));
  }

  /// Optionally mirror the recipient's shipping address into the tracking
  /// doc (same shape Florista already sends the backend when the order is
  /// placed: street/phone/city/lat/long), for the customer's live map.
  Future<void> pushShippingAddress({
    required String orderId,
    required String street,
    required String city,
    required String phone,
    double? lat,
    double? long,
  }) async {
    await _firestore.collection('orders').doc(orderId).set({
      'shippingAddress': {
        'street': street,
        'city': city,
        'phone': phone,
        if (lat != null) 'lat': lat,
        if (long != null) 'long': long,
      },
    }, SetOptions(merge: true));
  }

  /// Pushes the driver's current GPS position for [orderId] into Firestore
  /// at `orders/{orderId}.driverLocation`, so Florista's map screen can
  /// stream it live and move the driver marker in real time.
  ///
  /// Called every 5 seconds while the driver has the live tracking map
  /// open (see `MapCubit._startLiveTracking`). Uses `SetOptions(merge:
  /// true)` so it never clobbers `driverStatus`/`shippingAddress`/etc.
  /// written by [pushStatusUpdate] / [pushShippingAddress].
  Future<void> pushDriverLocation({
    required String orderId,
    required double lat,
    required double long,
  }) async {
    await _firestore.collection('orders').doc(orderId).set({
      'driverLocation': {'lat': lat, 'long': long},
      'driverLocationUpdatedAt': Timestamp.now(),
    }, SetOptions(merge: true));
  }
}
