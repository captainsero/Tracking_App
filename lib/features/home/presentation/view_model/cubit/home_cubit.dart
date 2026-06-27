import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/home/domain/entities/order_entity.dart';
import 'package:tracking_app/features/home/domain/use_cases/get_pending_orders_use_case.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_events.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:bloc/bloc.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetPendingOrdersUseCase getPendingOrdersUseCase;
  HomeCubit({required this.getPendingOrdersUseCase}) : super(HomeState());

  int _currentPage = 1;
  List<OrderEntity> _allOrders = [];

  void onEvent(HomeEvents event) {
    switch (event) {
      case GetPendingOrdersEvent():
        _getPendingOrders(refresh: event.refresh, completer: event.completer);

      case RejectOrderEvent():
        _rejectOrder(event.orderId);
    }
  }

  Future<void> _getPendingOrders({
    bool refresh = false,
    Completer<void>? completer,
  }) async {
    if (state.isLoadingMore || (!refresh && state.hasReachedMax)) return;
    try {
      if (refresh) {
        _currentPage = 1;
        emit(state.copyWith(hasReachedMax: false));
      }

      if (_currentPage == 1 && !refresh) {
        emit(state.copyWith(getPendingOrdersState: BaseState(isLoading: true)));
      } else if (_currentPage > 1) {
        emit(state.copyWith(isLoadingMore: true));
      }

      final response = await getPendingOrdersUseCase(page: _currentPage);
      final handler = ResponseToStateMapper.handle(response);

      bool reachedMax = false;

      if (handler.data != null) {
        final newOrders = handler.data as List<OrderEntity>;
        if (refresh) {
          _allOrders.clear();
        }

        if (newOrders.isEmpty) {
          reachedMax = true;
        } else {
          _allOrders = [..._allOrders, ...newOrders];
          _currentPage++;
        }
      } else {
        reachedMax = true;
      }

      emit(
        state.copyWith(
          getPendingOrdersState: BaseState(
            isLoading: handler.isLoading,
            data: List<OrderEntity>.from(_allOrders),
            errorMessage: handler.errorMessage,
          ),
          isLoadingMore: false,
          hasReachedMax: reachedMax,
        ),
      );
    } finally {
      if (state.isLoadingMore) {
        emit(state.copyWith(isLoadingMore: false));
      }
      if (completer != null && !completer.isCompleted) {
        completer.complete();
      }
    }
  }

  void _rejectOrder(String orderId) {
    _allOrders = _allOrders.where((order) => order.id != orderId).toList();

    emit(
      state.copyWith(
        getPendingOrdersState: BaseState(
          data: List<OrderEntity>.from(_allOrders),
        ),
      ),
    );
  }
}
