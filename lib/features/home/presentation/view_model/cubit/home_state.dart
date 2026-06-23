import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/home/domain/entities/order_entity.dart';

class HomeState extends Equatable {
  final BaseState<List<OrderEntity>> getPendingOrdersState;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const HomeState({
    this.getPendingOrdersState = const BaseState<List<OrderEntity>>(
      isLoading: false,
    ),
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  HomeState copyWith({
    BaseState<List<OrderEntity>>? getPendingOrdersState,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return HomeState(
      getPendingOrdersState:
          getPendingOrdersState ?? this.getPendingOrdersState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    getPendingOrdersState,
    isLoadingMore,
    hasReachedMax,
  ];
}
