import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/screen_size.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/features/home/presentation/widgets/home_order_card.dart';

class HomeOrderContainer extends StatelessWidget {
  const HomeOrderContainer({
    super.key,
    required this.pickupImage,
    required this.pickupName,
    required this.pickupAddress,
    required this.userImage,
    required this.userName,
    required this.userAddress,
    required this.price,
  });
  final String pickupImage;
  final String pickupName;
  final String pickupAddress;
  final String userImage;
  final String userName;
  final String userAddress;
  final double price;
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
              "Flower order",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),

            SizedBox(height: AppSize.s16),

            Text(
              "Pickup address",
              style: Theme.of(context).textTheme.bodySmall,
            ),

            HomeOrderCard(
              image: pickupImage,
              name: pickupName,
              address: pickupAddress,
            ),

            SizedBox(height: AppSize.s16),

            Text("User address", style: Theme.of(context).textTheme.bodySmall),

            HomeOrderCard(
              image: userImage,
              name: userName,
              address: userAddress,
            ),

            SizedBox(height: AppSize.s16),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "EGP $price",
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
                    onPressed: () {},
                    child: Text("Reject"),
                  ),
                ),

                SizedBox(
                  width: ScreenSize.width / 3,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Accept",
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
