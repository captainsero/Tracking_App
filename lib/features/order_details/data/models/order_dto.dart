import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/order_details/data/models/order_item_dto.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_status.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "user")
  final String user;
  @JsonKey(name: "orderItems")
  final List<OrderItemDto> orderItemsDto;
  @JsonKey(name: "totalPrice")
  final double totalPrice;
  @JsonKey(name: "paymentType")
  final String paymentType;
  @JsonKey(name: "isPaid")
  final bool isPaid;
  @JsonKey(name: "isDelivered")
  final bool isDelivered;
  @JsonKey(name: "state")
  final String state;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "orderNumber")
  final String orderNumber;
  @JsonKey(name: "__v")
  final int v;

  OrderDto({
    required this.id,
    required this.user,
    required this.orderItemsDto,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.v,
  });

  OrderDto copyWith({
    String? id,
    String? user,
    List<OrderItemDto>? orderItemsDto,
    double? totalPrice,
    String? paymentType,
    bool? isPaid,
    bool? isDelivered,
    String? state,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? orderNumber,
    int? v,
  }) => OrderDto(
    id: id ?? this.id,
    user: user ?? this.user,
    orderItemsDto: orderItemsDto ?? this.orderItemsDto,
    totalPrice: totalPrice ?? this.totalPrice,
    paymentType: paymentType ?? this.paymentType,
    isPaid: isPaid ?? this.isPaid,
    isDelivered: isDelivered ?? this.isDelivered,
    state: state ?? this.state,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    orderNumber: orderNumber ?? this.orderNumber,
    v: v ?? this.v,
  );

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);

  OrderEntity toEntity() => OrderEntity(
    id: id,
    status: OrderStatus.fromString(state),
    createdAt: createdAt,
    items: orderItemsDto.map((item) => item.toEntity()).toList(),
    paymentMethod: paymentType,
  );
}
