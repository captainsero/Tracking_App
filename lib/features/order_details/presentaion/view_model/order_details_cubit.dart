import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_status.dart';
import 'package:tracking_app/features/order_details/domain/repo/order_details_repo_contract.dart';
import 'package:tracking_app/features/order_details/presentaion/view_model/order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit({required this.orderDetailsRepoContract})
    : super(OrderDetailsState());

  final OrderDetailsRepoContract orderDetailsRepoContract;

  Future<void> startOrder(String orderId) async {
    emit(
      state.copyWith(
        orderDetailsState: BaseState<OrderEntity>(isLoading: true),
      ),
    );
    final response = await orderDetailsRepoContract.startOrder(orderId);
    final handler = ResponseToStateMapper.handle(response);
    emit(state.copyWith(orderDetailsState: handler));
  }

  Future<void> advanceStatus(String orderId, OrderStatus nextStatus) async {
    final currentOrder = state.orderDetailsState.data;
    if (currentOrder == null) return;

    emit(state.copyWith(isAdvancingStatus: true));
    try {
      await orderDetailsRepoContract.updateStatus(orderId, nextStatus);
      emit(
        state.copyWith(
          orderDetailsState: BaseState<OrderEntity>(
            data: currentOrder.copyWith(status: nextStatus),
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          orderDetailsState: BaseState<OrderEntity>(errorMessage: e.toString()),
        ),
      );
    } finally {
      emit(state.copyWith(isAdvancingStatus: false));
    }
  }
}
