import 'package:tracking_app/features/home/domain/entities/shipping_address_entity.dart';
import 'package:tracking_app/features/home/domain/entities/store_entity.dart';
import 'package:tracking_app/features/home/domain/entities/user_entity.dart';

class OrderEntity {
  final String id;
  final StoreEntity store;
  final UserEntity user;
  final ShippingAddressEntity shippingAddress;
  final double totalPrice;

  OrderEntity({
    required this.id,
    required this.store,
    required this.user,
    required this.shippingAddress,
    required this.totalPrice,
  });

}
