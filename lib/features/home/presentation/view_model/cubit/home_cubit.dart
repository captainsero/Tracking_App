import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/home/domain/use_cases/get_pending_orders_use_case.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_events.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:bloc/bloc.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetPendingOrdersUseCase getPendingOrdersUseCase;
  HomeCubit({required this.getPendingOrdersUseCase}) : super(HomeState());

  void onEvent(HomeEvents event) {
    switch (event) {
      case GetPendingOrdersEvent():
        _getPendingOrders();
        break;
    }
  }

  Future<void> _getPendingOrders() async {
    emit(state.copyWith(getPendingOrdersState: BaseState(isLoading: true)));
    final response = await getPendingOrdersUseCase();
    final handler = ResponseToStateMapper.handle(response);
    emit(
      state.copyWith(
        getPendingOrdersState: BaseState(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
