class ProfileDataEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photo;
  final String gender;

  ProfileDataEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
  });

  String get fullName => '$firstName $lastName';
}
