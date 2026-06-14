import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool? isLoading;
  final T? data;
  final String? errorMessage;
  const BaseState({this.isLoading, this.data, this.errorMessage});

  BaseState<T> copyWith({bool? isLoading, String? errorMessage, T? data}) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
