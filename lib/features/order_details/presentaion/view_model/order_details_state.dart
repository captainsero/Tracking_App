import 'package:equatable/equatable.dart';

import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';

class OrderDetailsState extends Equatable {
  final BaseState<OrderEntity> orderDetailsState;
  final bool isAdvancingStatus;

  const OrderDetailsState({
    this.orderDetailsState = const BaseState<OrderEntity>(isLoading: false),
    this.isAdvancingStatus = false,
  });

  @override
  List<Object?> get props => [orderDetailsState, isAdvancingStatus];

  OrderDetailsState copyWith({
    BaseState<OrderEntity>? orderDetailsState,
    bool? isAdvancingStatus,
  }) {
    return OrderDetailsState(
      orderDetailsState: orderDetailsState ?? this.orderDetailsState,
      isAdvancingStatus: isAdvancingStatus ?? this.isAdvancingStatus,
    );
  }
}
