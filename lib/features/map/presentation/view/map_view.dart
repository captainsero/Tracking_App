import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/config/shared_models/map_extra.dart';
import 'package:tracking_app/core/constants/screen_size.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/features/map/presentation/widgets/map_order_container.dart';
import 'package:tracking_app/features/map/presentation/widgets/order_map_widget.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.mapExtra});

  final MapExtra mapExtra;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late LatLng endLocation;

  @override
  void initState() {
    super.initState();

    final lat = double.tryParse(widget.mapExtra.shippingAddressEntity.lat) ?? 0;

    final long =
        double.tryParse(widget.mapExtra.shippingAddressEntity.long) ?? 0;

    endLocation = LatLng(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Location')),

      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),

        child: Column(
          children: [
            SizedBox(
              height: ScreenSize.height / 2,
              child: OrderMapWidget(
                endLocation: endLocation,
                orderId: widget.mapExtra.orderId,
              ),
            ),

            Divider(
              color: Theme.of(context).primaryColor,
              thickness: AppSize.s5,
              indent: AppSize.s150,
              endIndent: AppSize.s150,
              radius: BorderRadius.circular(RadiusSize.r10),
            ),

            MapOrderContainer(
              storeEntity: widget.mapExtra.storeEntity,

              shippingAddressEntity: widget.mapExtra.shippingAddressEntity,

              userEntity: widget.mapExtra.userEntity,
            ),
          ],
        ),
      ),
    );
  }
}
