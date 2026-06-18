class SignUpEntity {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicensePath;
  final String email;
  final String phone;
  final String nid;
  final String nidImagePath;
  final String password;
  final String rePassword;
  final String gender;

  const SignUpEntity({
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicensePath,
    required this.email,
    required this.phone,
    required this.nid,
    required this.nidImagePath,
    required this.password,
    required this.rePassword,
    required this.gender,
  });
}
