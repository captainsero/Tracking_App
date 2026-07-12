import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/config/shared_models/map_extra.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/screen_size.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/home/domain/entities/shipping_address_entity.dart';
import 'package:tracking_app/features/home/domain/entities/store_entity.dart';
import 'package:tracking_app/features/home/domain/entities/user_entity.dart';
import 'package:tracking_app/features/home/presentation/widgets/home_order_card.dart';
import 'package:tracking_app/generated/l10n.dart';

class HomeOrderContainer extends StatelessWidget {
  const HomeOrderContainer({
    super.key,
    required this.onReject,
    required this.orderId,
    required this.storeEntity,
    required this.shippingAddressEntity,
    required this.userEntity,
    required this.totalPrice,
  });
  final VoidCallback onReject;
  final String orderId;
  final StoreEntity storeEntity;
  final ShippingAddressEntity shippingAddressEntity;
  final UserEntity userEntity;
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      child: SizedBox(
        width: .infinity,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              S.current.flowerOrder,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),

            SizedBox(height: AppSize.s16),

            Text(
              S.current.pickupAdderss,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            HomeOrderCard(
              image: storeEntity.image,
              name: storeEntity.name,
              address: storeEntity.address,
            ),

            SizedBox(height: AppSize.s16),

            Text(
              S.current.userAddress,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            HomeOrderCard(
              image: userEntity.photo,
              name: '${userEntity.firstName} ${userEntity.lastName}',
              address: shippingAddressEntity.city,
            ),

            SizedBox(height: AppSize.s16),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "${S.current.egp} ${totalPrice.toStringAsFixed(0)}",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontSize: FontSize.s14),
                ),

                SizedBox(
                  width: ScreenSize.width / 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: onReject,
                    child: Text(S.current.reject),
                  ),
                ),

                SizedBox(
                  width: ScreenSize.width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go(
                        RoutePath.map,
                        extra: MapExtra(
                          orderId: orderId,
                          storeEntity: storeEntity,
                          shippingAddressEntity: shippingAddressEntity,
                          userEntity: userEntity,
                        ),
                      );
                    },
                    child: Text(
                      S.current.accept,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
