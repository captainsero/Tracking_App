import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:tracking_app/features/order_details/data/models/order_dto.dart';

part 'order_details_response_model.g.dart';

OrderDetailsResponseModel orderDetailsResponseModelFromJson(String str) =>
    OrderDetailsResponseModel.fromJson(json.decode(str));

String orderDetailsResponseModelToJson(OrderDetailsResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class OrderDetailsResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "orders")
  final OrderDto orderDto;

  OrderDetailsResponseModel({required this.message, required this.orderDto});

  OrderDetailsResponseModel copyWith({String? message, OrderDto? orderDto}) =>
      OrderDetailsResponseModel(
        message: message ?? this.message,
        orderDto: orderDto ?? this.orderDto,
      );

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsResponseModelToJson(this);
}
