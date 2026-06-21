import 'order_status.dart';

/// A single line item within an order (e.g. one bouquet type).
class OrderItem {
  final String id;
  final String name;
  final String? imageUrl;
  final int quantity;
  final double price;
  final String currency;

  const OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl,
    this.currency = 'EGP',
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'EGP',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'quantity': quantity,
    'price': price,
    'currency': currency,
  };
}

/// Pickup location or recipient — both addresses in the design share
/// this exact shape (avatar/icon, name, address, phone), so one model
/// covers both instead of duplicating fields.
class ContactInfo {
  final String name;
  final String address;
  final String? avatarUrl;
  final String phoneNumber;

  const ContactInfo({
    required this.name,
    required this.address,
    required this.phoneNumber,
    this.avatarUrl,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'phoneNumber': phoneNumber,
    'avatarUrl': avatarUrl,
  };
}

class Order {
  final String id;
  final OrderStatus status;
  final DateTime createdAt;
  final ContactInfo pickupContact;
  final ContactInfo userContact;
  final List<OrderItem> items;
  final String paymentMethod;
  final String currency;

  const Order({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.pickupContact,
    required this.userContact,
    required this.items,
    required this.paymentMethod,
    this.currency = 'EGP',
  });

  double get total =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      status: OrderStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      pickupContact: ContactInfo.fromJson(
        json['pickupContact'] as Map<String, dynamic>,
      ),
      userContact: ContactInfo.fromJson(
        json['userContact'] as Map<String, dynamic>,
      ),
      items: (json['items'] as List)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethod: json['paymentMethod'] as String,
      currency: json['currency'] as String? ?? 'EGP',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status.apiValue,
    'createdAt': createdAt.toIso8601String(),
    'pickupContact': pickupContact.toJson(),
    'userContact': userContact.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
    'currency': currency,
  };

  /// Convenience for Cubit/Firestore listeners: rebuild the same order
  /// with just the status swapped, without re-parsing JSON.
  Order copyWith({OrderStatus? status}) {
    return Order(
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
