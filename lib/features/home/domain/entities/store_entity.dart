class StoreEntity {
  final String image;
  final String name;
  final String address;
  final String latLong;
  final String phone;

  StoreEntity({
    required this.image,
    required this.name,
    required this.address,
    required this.latLong,
    required this.phone,
  });

  factory StoreEntity.empty() {
    return StoreEntity(
      image: '',
      name: '',
      address: '',
      latLong: '',
      phone: '',
    );
  }
}
