import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_item_entity.dart';

part 'order_item_dto.g.dart';

@JsonSerializable()
class OrderItemDto {
  @JsonKey(name: "product")
  final String product;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "quantity")
  final int quantity;
  @JsonKey(name: "_id")
  final String id;

  OrderItemDto({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  OrderItemDto copyWith({
    String? product,
    double? price,
    int? quantity,
    String? id,
  }) => OrderItemDto(
    product: product ?? this.product,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    id: id ?? this.id,
  );

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);

  OrderItemEntity toEntity() =>
      OrderItemEntity(price: price, quantity: quantity, id: id, name: product);
}
