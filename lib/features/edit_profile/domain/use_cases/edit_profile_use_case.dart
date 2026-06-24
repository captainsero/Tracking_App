import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';

@lazySingleton
class EditProfileUseCase {
  final EditProfileRepository repository;

  EditProfileUseCase({required this.repository});

  Future<BaseResponse<EditProfileResponseEntity>> call({
    required String? firstName,
    required String? lastName,
    required String? phone,
  }) async {
    return await repository.editProfile(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );
  }
}
