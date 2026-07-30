import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:tracking_app/features/auth/sign_up/domain/repo/sign_up_repo.dart';
import 'package:tracking_app/features/auth/sign_up/data/data_source/sign_up_remote_data_source.dart';
import 'package:tracking_app/features/auth/sign_up/data/models/sign_up_request_model.dart';

@Injectable(as: SignUpRepo)
class SignUpRepoImpl implements SignUpRepo {
  final SignUpRemoteDataSource _dataSource;
  const SignUpRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<void>> signUp(SignUpEntity entity) =>
      _dataSource.signUp(
        model: SignUpRequestModel(
          country: entity.country,
          firstName: entity.firstName,
          lastName: entity.lastName,
          vehicleType: entity.vehicleType,
          vehicleNumber: entity.vehicleNumber,
          email: entity.email,
          phone: entity.phone,
          nid: entity.nid,
          password: entity.password,
          rePassword: entity.rePassword,
          gender: entity.gender,
        ),
        vehicleLicensePath: entity.vehicleLicensePath,
        nidImagePath: entity.nidImagePath,
      );
}
