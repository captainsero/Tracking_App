import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';

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
      return ErrorBaseResponse(error: e);
    }
  }

  Future<BaseResponse<String>> read({required String key}) async {
    try {
      final value = await _storage.read(key: key);

      if (value == null) {
        return ErrorBaseResponse(error: KeyNotFoundException(key));
      }

      return SuccessBaseResponse(data: value);
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  Future<BaseResponse<bool>> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
      return SuccessBaseResponse(data: true);
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  Future<BaseResponse<bool>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return SuccessBaseResponse(data: true);
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}

class KeyNotFoundException implements Exception {
  final String key;
  KeyNotFoundException(this.key);
}
