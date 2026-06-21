import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/home/data/models/metadata.dart';
import 'package:tracking_app/features/home/data/models/order_model.dart';

part 'get_orders_response.g.dart';

@JsonSerializable()
class GetOrdersRequest {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "orders")
  final List<OrderModel>? orders;

  GetOrdersRequest({this.message, this.metadata, this.orders});

  factory GetOrdersRequest.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrdersRequestToJson(this);
}
