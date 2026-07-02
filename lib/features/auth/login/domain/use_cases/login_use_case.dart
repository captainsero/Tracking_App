import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../entities/login_params.dart';
import '../entities/login_response_entity.dart';
import '../repositories/login_repository.dart';

@lazySingleton
@Injectable(as: LoginUseCase)
class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<BaseResponse<LoginResponseEntity>> call({
    required LoginParams params,
  }) async {
    return repository.loginUser(params: params);
  }
}
