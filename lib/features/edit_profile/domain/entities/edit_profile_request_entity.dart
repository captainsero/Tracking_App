import 'package:equatable/equatable.dart';

class EditProfileRequestEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? gender;

  const EditProfileRequestEntity({
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
  });

  @override
  List<Object?> get props => [firstName, lastName, phone, gender];
}

