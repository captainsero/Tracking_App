import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/features/home/domain/entities/shipping_address_entity.dart';
import 'package:tracking_app/features/home/domain/entities/store_entity.dart';
import 'package:tracking_app/features/home/domain/entities/user_entity.dart';
import 'package:tracking_app/features/map/presentation/widgets/map_order_card.dart';
import 'package:tracking_app/generated/l10n.dart';

class MapOrderContainer extends StatelessWidget {
  const MapOrderContainer({
    super.key,
    required this.storeEntity,
    required this.shippingAddressEntity,
    required this.userEntity,
  });
  final StoreEntity storeEntity;
  final ShippingAddressEntity shippingAddressEntity;
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      child: SizedBox(
        width: .infinity,
        child: Column(
          crossAxisAlignment: .start,
          spacing: AppSize.s24,
          children: [
            SizedBox(height: AppSize.s3),
            Text(
              S.current.pickupAdderss,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            MapOrderCard(
              image: storeEntity.image,
              name: storeEntity.name,
              address: storeEntity.address,
              phone: storeEntity.phone,
            ),

            Text(
              S.current.userAddress,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            MapOrderCard(
              image: userEntity.photo,
              name: '${userEntity.firstName} ${userEntity.lastName}',
              address: shippingAddressEntity.city,
              phone: userEntity.phone,
            ),
          ],
        ),
      ),
    );
  }
}
