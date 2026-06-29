import 'package:tracking_app/features/home/domain/entities/shipping_address_entity.dart';
import 'package:tracking_app/features/home/domain/entities/store_entity.dart';
import 'package:tracking_app/features/home/domain/entities/user_entity.dart';

class MapExtra {
  final StoreEntity storeEntity;
  final ShippingAddressEntity shippingAddressEntity;
  final UserEntity userEntity;

  MapExtra({
    required this.storeEntity,
    required this.shippingAddressEntity,
    required this.userEntity,
  });
}
