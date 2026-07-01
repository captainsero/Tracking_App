import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/map/data/models/map_path_model.dart';
import 'package:tracking_app/features/map/data/models/map_path_response_model.dart';
import 'package:tracking_app/features/map/data/data_sources/map_remote_data_source_contract.dart';
import 'package:tracking_app/features/map/domain/repo/map_repo_contract.dart';

@Injectable(as: MapRepoContract)
class MapRepoImpl implements MapRepoContract {
  final MapRemoteDataSourceContract _remoteDataSourceContract;

  MapRepoImpl({required MapRemoteDataSourceContract remoteDataSourceContract})
    : _remoteDataSourceContract = remoteDataSourceContract;
  @override
  Future<BaseResponse<List<MapPathModel>>> getRoutePoints({
    required String coordinates,
  }) async {
    final response = await _remoteDataSourceContract.getRoutePoints(
      coordinates: coordinates,
    );
    switch (response) {
      case SuccessBaseResponse<MapPathResponseModel>():
        return SuccessBaseResponse<List<MapPathModel>>(
          data: response.data.mapPaths ?? [],
        );
      case ErrorBaseResponse<MapPathResponseModel>():
        return ErrorBaseResponse<List<MapPathModel>>(error: response.error);
    }
  }
}
