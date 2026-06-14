import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/generated/l10n.dart';

@singleton
class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<BaseResponse<String>> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
      return SuccessBaseResponse(data: key);
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: S.current.secureStorageErrorMessage,
      );
    }
  }

  Future<BaseResponse<String>> read({required String key}) async {
    try {
      final value = await _storage.read(key: key);

      if (value == null) {
        return ErrorBaseResponse(
          errorMessage: '${S.current.noValueKeyFound}$key',
        );
      }

      return SuccessBaseResponse(data: value);
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: S.current.secureStorageErrorMessage,
      );
    }
  }

  Future<BaseResponse<bool>> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
      return SuccessBaseResponse(data: true);
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: S.current.secureStorageErrorMessage,
      );
    }
  }

  Future<BaseResponse<bool>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return SuccessBaseResponse(data: true);
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: S.current.secureStorageErrorMessage,
      );
    }
  }
}
