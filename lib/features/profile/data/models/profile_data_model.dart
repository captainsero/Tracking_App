import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/profile/domain/entities/profile_data_entity.dart';

part 'profile_data_model.g.dart';

@JsonSerializable()
class ProfileDataModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'gender')
  final String gender;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'photo')
  final String photo;

  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'wishlist', defaultValue: [])
  final List<dynamic> wishlist;

  @JsonKey(name: 'addresses', defaultValue: [])
  final List<dynamic> addresses;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  ProfileDataModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    this.wishlist = const [],
    this.addresses = const [],
    required this.createdAt,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    // The API wraps driver data under a 'driver' key:
    // { "message": "success", "driver": { ... } }
    // Unwrap it if present so the generated code can read the fields.
    final data = json.containsKey('driver')
        ? json['driver'] as Map<String, dynamic>
        : json;
    return _$ProfileDataModelFromJson(data);
  }

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);

  ProfileDataEntity toEntity() {
    return ProfileDataEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      photo: photo,
      gender: gender,
    );
  }
}
