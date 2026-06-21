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

  int currentPage = 1;
  bool isLoadingMore = false;
  List<OrderEntity> allOrders = [];

  void onEvent(HomeEvents event) {
    switch (event) {
      case GetPendingOrdersEvent():
        _getPendingOrders(refresh: event.refresh);

      case RejectOrderEvent():
        _rejectOrder(event.orderId);
    }
  }

  Future<void> _getPendingOrders({bool refresh = false}) async {
    if (isLoadingMore) return;

    isLoadingMore = true;

    if (refresh) {
      currentPage = 1;
      allOrders.clear();
    }

    if (currentPage == 1) {
      emit(state.copyWith(getPendingOrdersState: BaseState(isLoading: true)));
    }

    final response = await getPendingOrdersUseCase(page: currentPage);
    final handler = ResponseToStateMapper.handle(response);

    if (handler.data != null) {
      allOrders = [...allOrders, ...(handler.data as List<OrderEntity>)];

      currentPage++;
    }

    isLoadingMore = false;

    emit(
      state.copyWith(
        getPendingOrdersState: BaseState(
          isLoading: false,
          data: List<OrderEntity>.from(allOrders),
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  void _rejectOrder(String orderId) {
    allOrders = allOrders.where((order) => order.id != orderId).toList();

    emit(
      state.copyWith(
        getPendingOrdersState: BaseState(
          data: List<OrderEntity>.from(allOrders),
        ),
      ),
    );
  }
}
