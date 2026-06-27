import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:tracking_app/features/auth/sign_up/domain/repo/sign_up_repo.dart';

@injectable
class SignUpUseCase {
  final SignUpRepo _repo;
  const SignUpUseCase(this._repo);

  Future<BaseResponse<void>> call(SignUpEntity entity) =>
      _repo.signUp(entity);
}
