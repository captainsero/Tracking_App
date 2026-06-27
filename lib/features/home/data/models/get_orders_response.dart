import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/home/data/models/metadata.dart';
import 'package:tracking_app/features/home/data/models/order_model.dart';

part 'get_orders_response.g.dart';

@JsonSerializable()
class GetOrdersResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "orders")
  final List<OrderModel>? orders;

  GetOrdersResponse({this.message, this.metadata, this.orders});

  factory GetOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrdersResponseToJson(this);
}
