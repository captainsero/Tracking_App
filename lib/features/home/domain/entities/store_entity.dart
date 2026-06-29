class StoreEntity {
  final String image;
  final String name;
  final String address;
  final String latLong;

  StoreEntity({
    required this.image,
    required this.name,
    required this.address,
    required this.latLong,
  });

  factory StoreEntity.empty() {
    return StoreEntity(image: '', name: '', address: '', latLong: '');
  }
}
