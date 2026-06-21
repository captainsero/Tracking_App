import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/values_manager.dart';

class HomeOrderCard extends StatelessWidget {
  const HomeOrderCard({
    super.key,
    required this.image,
    required this.name,
    required this.address,
  });
  final String image;
  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: RadiusSize.r20,
            ),
          ),

          Column(
            crossAxisAlignment: .start,
            children: [
              Text(name, style: Theme.of(context).textTheme.bodySmall),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: AppSize.s16),
                  Text(address, style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
