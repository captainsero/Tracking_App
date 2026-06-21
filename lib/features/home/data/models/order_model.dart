import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/home/data/models/order_item_model.dart';
import 'package:tracking_app/features/home/data/models/shipping_address_model.dart';
import 'package:tracking_app/features/home/data/models/store_model.dart';
import 'package:tracking_app/features/home/data/models/user_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final UserModel? user;
  @JsonKey(name: "orderItems")
  final List<OrderItemModel>? orderItems;
  @JsonKey(name: "totalPrice")
  final double? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "store")
  final StoreModel? store;
  @JsonKey(name: "shippingAddress")
  final ShippingAddressModel? shippingAddress;
  @JsonKey(name: "paidAt")
  final DateTime? paidAt;

  OrderModel({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
    this.shippingAddress,
    this.paidAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
