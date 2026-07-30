class SignUpRequestModel {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String email;
  final String phone;
  final String nid;
  final String password;
  final String rePassword;
  final String gender;

  const SignUpRequestModel({
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.email,
    required this.phone,
    required this.nid,
    required this.password,
    required this.rePassword,
    required this.gender,
  });

  /// Keys match the Postman form-data fields exactly.
  Map<String, dynamic> toJson() => {
    'country': country,
    'firstName': firstName,
    'lastName': lastName,
    'vehicleType': vehicleType,
    'vehicleNumber': vehicleNumber,
    'email': email,
    'phone': phone,
    'NID': nid,
    'password': password,
    'rePassword': rePassword,
    'gender': gender,
  };
}
