class UserEntity {
  final String photo;
  final String firstName;
  final String lastName;
  final String phone;

  UserEntity({
    required this.photo,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  factory UserEntity.empty() {
    return UserEntity(photo: '', firstName: '', lastName: '', phone: '');
  }
}
