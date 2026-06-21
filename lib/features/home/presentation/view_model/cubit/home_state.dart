import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/home/domain/entities/order_entity.dart';

class HomeState extends Equatable {
  final BaseState<List<OrderEntity>> getPendingOrdersState;

  HomeState({BaseState<List<OrderEntity>>? getPendingOrdersState})
    : getPendingOrdersState =
          getPendingOrdersState ??
          BaseState<List<OrderEntity>>(isLoading: false);

  HomeState copyWith({BaseState<List<OrderEntity>>? getPendingOrdersState}) {
    return HomeState(
      getPendingOrdersState:
          getPendingOrdersState ?? this.getPendingOrdersState,
    );
  }

  @override
  List<Object?> get props => [getPendingOrdersState];
}
