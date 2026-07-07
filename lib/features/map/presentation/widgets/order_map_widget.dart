import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/constants/api_constants/base_urls.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/features/map/presentation/view_model/map_event.dart';
import 'package:tracking_app/features/map/presentation/view_model/map_state.dart';
import 'package:tracking_app/features/map/presentation/view_model/map_view_model.dart';
import 'package:tracking_app/features/map/presentation/widgets/custom_marker.dart';

class OrderMapWidget extends StatefulWidget {
  const OrderMapWidget({super.key, required this.endLocation});

  final LatLng endLocation;

  @override
  State<OrderMapWidget> createState() => _OrderMapWidgetState();
}

class _OrderMapWidgetState extends State<OrderMapWidget> {
  late final MapController mapController;

  @override
  void initState() {
    super.initState();

    mapController = MapController();

    context.read<MapCubit>().onEvent(
      GetRouteEvent(endPoint: widget.endLocation),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) =>
          previous.getRouteState != current.getRouteState,
      builder: (context, state) {
        if (state.getRouteState.isLoading == true) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.getRouteState.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off,
                  size: 60,
                  color: Theme.of(context).colorScheme.error,
                ),

                const SizedBox(height: 12),

                Text(
                  state.getRouteState.errorMessage!,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    context.read<MapCubit>().onEvent(
                      GetRouteEvent(endPoint: widget.endLocation),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: state.currentDeliveryLocation!,
            initialZoom: 15.5,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),

          children: [
            TileLayer(
              urlTemplate: BaseUrls.mapTileUrlTemplate,
              subdomains: AppConstants.mapTileSubdomains,
              userAgentPackageName: AppConstants.userAgentPackageName,
            ),

            if (state.getRouteState.data?.isNotEmpty == true)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: state.getRouteState.data!,
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 4,
                  ),
                ],
              ),

            MarkerLayer(
              markers: [
                Marker(
                  point: widget.endLocation,
                  width: 30,
                  height: 30,
                  child: const CustomMarker(icon: Icons.home),
                ),

                Marker(
                  point: state.currentDeliveryLocation!,
                  width: 30,
                  height: 30,
                  child: const CustomMarker(icon: Icons.local_shipping),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
