import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/features/order_details/domain/entities/order_entity.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/contact_card.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/order_item_tile.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/order_status_banner.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/order_stepper_widget.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/order_summary.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/primary_action_button.dart';

/// Order details screen — currently takes a plain [Order] object so it
/// works standalone today.
///
/// CUBIT MIGRATION NOTE:
/// When OrderCubit is ready, wrap the `body:` in a BlocBuilder and swap
/// the constructor to take an `orderId` instead of an `Order`. None of
/// the child widgets need to change — only this file's data source and
/// the `_isUpdatingStatus` / `_onActionPressed` plumbing below, which
/// exist as the explicit seam for that swap.
class OrderDetailsScreen extends StatefulWidget {
  final Order order;

  /// Called when the user taps the bottom CTA. Receives the *current*
  /// order so the caller (eventually a Cubit) decides what "next status"
  /// means — this screen doesn't hardcode that transition itself beyond
  /// reading the suggested label/next status off [OrderStatus].
  final Future<void> Function(Order order)? onAdvanceStatus;

  const OrderDetailsScreen({
    super.key,
    required this.order,
    this.onAdvanceStatus,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool _isUpdatingStatus = false;

  Future<void> _onActionPressed() async {
    if (widget.onAdvanceStatus == null) return;
    setState(() => _isUpdatingStatus = true);
    try {
      await widget.onAdvanceStatus!(widget.order);
    } finally {
      if (mounted) setState(() => _isUpdatingStatus = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final nextLabel = order.status.nextActionLabel;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Order details',
          style: TextStyle(color: AppColors.black, fontSize: 17),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                children: [
                  OrderProgressStepper(activeStep: order.status.stepIndex),
                  const SizedBox(height: 20),
                  OrderStatusBanner(
                    status: order.status,
                    orderId: order.id,
                    createdAt: order.createdAt,
                  ),
                  const SizedBox(height: 24),
                  _SectionTitle('Pickup address'),
                  const SizedBox(height: 10),
                  ContactCard(
                    contact: order.pickupContact,
                    onCallTap: () => _placeholderAction(context, 'call pickup'),
                    onWhatsAppTap: () =>
                        _placeholderAction(context, 'WhatsApp pickup'),
                  ),
                  const SizedBox(height: 20),
                  _SectionTitle('User address'),
                  const SizedBox(height: 10),
                  ContactCard(
                    contact: order.userContact,
                    onCallTap: () => _placeholderAction(context, 'call user'),
                    onWhatsAppTap: () =>
                        _placeholderAction(context, 'WhatsApp user'),
                  ),
                  const SizedBox(height: 20),
                  _SectionTitle('Order details'),
                  const SizedBox(height: 10),
                  ...order.items.map((item) => OrderItemTile(item: item)),
                  const SizedBox(height: 6),
                  OrderSummaryCard(
                    total: order.total,
                    currency: order.currency,
                    paymentMethod: order.paymentMethod,
                  ),
                ],
              ),
            ),
            if (nextLabel != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: PrimaryActionButton(
                  label: nextLabel,
                  isLoading: _isUpdatingStatus,
                  onPressed: widget.onAdvanceStatus == null
                      ? null
                      : _onActionPressed,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Stand-in until call/WhatsApp launching (e.g. url_launcher) is wired up.
  void _placeholderAction(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('TODO: $action'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
