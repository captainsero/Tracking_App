class ShippingAddressEntity {
  final String street;
  final String city;
  final String lat;
  final String long;

  ShippingAddressEntity({
    required this.street,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory ShippingAddressEntity.empty() {
    return ShippingAddressEntity(street: '', city: '', lat: '', long: '');
  }
}
