import 'package:tracking_app/config/base_response/base_response.dart';

abstract class ProfileRepoContract {
  Future<BaseResponse<String>> logout();
}
