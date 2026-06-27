// ── Vehicle Card ──────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/router/route_path.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vehicle info',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Bike',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'UP16DL0007',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                context.push(
                  RoutePath.editVehicle,
                  extra: {
                    'vehicleType': 'Bicycle',
                    'vehicleNumber': 'UP16DL0007',
                    'vehicleLicense': '',
                  },
                );
              },
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.pink,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
