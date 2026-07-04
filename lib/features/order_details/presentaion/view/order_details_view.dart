import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';
import 'package:tracking_app/features/order_details/presentaion/view_model/order_details_cubit.dart';
import 'package:tracking_app/features/order_details/presentaion/view_model/order_details_state.dart';
import 'package:tracking_app/features/order_details/presentaion/widgets/contact_card.dart';
import 'package:tracking_app/features/order_details/presentaion/widgets/order_item_tile.dart';
import 'package:tracking_app/features/order_details/presentaion/widgets/order_status_banner.dart';
import 'package:tracking_app/features/order_details/presentaion/widgets/order_stepper_widget.dart';
import 'package:tracking_app/features/order_details/presentaion/widgets/order_summary.dart';
import 'package:tracking_app/features/order_details/presentaion/widgets/primary_action_button.dart';
import 'package:tracking_app/generated/l10n.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  StreamSubscription<BaseState<OrderEntity>>? _errorSub;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<OrderDetailsCubit>();
    cubit.startOrder(widget.orderId); // initial fetch

    // Streamer: side effects only — no setState, no rebuild here
    _errorSub = cubit.stream
        .map((state) => state.orderDetailsState)
        .distinct()
        .listen(_handleOrderErrors);
  }

  void _handleOrderErrors(BaseState<OrderEntity> state) {
    if (!mounted) return;
    if (state.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    }
  }

  @override
  void dispose() {
    _errorSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackButton(color: AppColors.black),
        title: Text(
          S.of(context).orderDetails,
          style: TextStyle(color: AppColors.black, fontSize: 17),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          buildWhen: (prev, curr) =>
              prev.orderDetailsState != curr.orderDetailsState ||
              prev.isAdvancingStatus != curr.isAdvancingStatus,
          builder: (context, state) {
            final orderState = state.orderDetailsState;

            if (orderState.isLoading == true) {
              return const Center(child: CircularProgressIndicator());
            }

            final order = orderState.data;
            if (order == null) {
              return Center(child: Text(orderState.errorMessage ?? ''));
            }

            return _OrderDetailsBody(
              order: order,
              isUpdatingStatus:
                  state.isAdvancingStatus, // from Cubit, not setState
              onAdvanceStatus: () => context
                  .read<OrderDetailsCubit>()
                  .advanceStatus(order.id, order.status),
            );
          },
        ),
      ),
    );
  }
}

class _OrderDetailsBody extends StatelessWidget {
  final OrderEntity order;
  final bool isUpdatingStatus;
  final VoidCallback onAdvanceStatus;

  const _OrderDetailsBody({
    required this.order,
    required this.isUpdatingStatus,
    required this.onAdvanceStatus,
  });

  @override
  Widget build(BuildContext context) {
    final nextLabel = order.status.nextActionLabel;

    return Column(
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
              _SectionTitle(S.of(context).pickupAddress),
              const SizedBox(height: 10),
              ContactCard(
                contact: order.pickupContact!,
                onCallTap: () => _placeholderAction(context, 'call pickup'),
                onWhatsAppTap: () =>
                    _placeholderAction(context, 'WhatsApp pickup'),
              ),
              const SizedBox(height: 20),
              _SectionTitle(S.of(context).userAddress),
              const SizedBox(height: 10),
              ContactCard(
                contact: order.userContact!,
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
              isLoading: isUpdatingStatus,
              onPressed: onAdvanceStatus,
            ),
          ),
      ],
    );
  }

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
