class EditProfileRequestEntity {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? country;
  final String? gender;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  final String? nid;
  final String? nidImg;

  const EditProfileRequestEntity({
    this.firstName,
    this.lastName,
    this.phone,
    this.country,
    this.gender,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nidImg,
  });
}
