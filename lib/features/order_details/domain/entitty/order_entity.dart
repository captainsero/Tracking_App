import 'package:tracking_app/features/order_details/domain/entitty/contact_info.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_item_entity.dart';

import 'order_status.dart';

class OrderEntity {
  final String id;
  final OrderStatus status;
  final DateTime createdAt;
  final ContactInfo? pickupContact;
  final ContactInfo? userContact;
  final List<OrderItemEntity> items;
  final String paymentMethod;
  final String currency;

  const OrderEntity({
    required this.id,
    required this.status,
    required this.createdAt,
    this.pickupContact,
    this.userContact,
    required this.items,
    required this.paymentMethod,
    this.currency = 'EGP',
  });

  double get total =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'] as String,
      status: OrderStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      pickupContact: json['pickupContact'] != null
          ? ContactInfo.fromJson(json['pickupContact'] as Map<String, dynamic>)
          : null,
      userContact: json['userContact'] != null
          ? ContactInfo.fromJson(json['userContact'] as Map<String, dynamic>)
          : null,
      items: (json['items'] as List)
          .map((e) => OrderItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethod: json['paymentMethod'] as String,
      currency: json['currency'] as String? ?? 'EGP',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status.toRemoteValue,
    'createdAt': createdAt.toIso8601String(),
    'pickupContact': pickupContact!.toJson(),
    'userContact': userContact!.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
    'currency': currency,
  };

  /// Convenience for Cubit/Firestore listeners: rebuild the same order
  /// with just the status swapped, without re-parsing JSON.
  OrderEntity copyWith({OrderStatus? status}) {
    return OrderEntity(
      id: id,
      status: status ?? this.status,
      createdAt: createdAt,
      pickupContact: pickupContact,
      userContact: userContact,
      items: items,
      paymentMethod: paymentMethod,
      currency: currency,
    );
  }
}
