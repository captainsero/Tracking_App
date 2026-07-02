import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/map/data/models/map_path_model.dart';
import 'package:tracking_app/features/map/domain/repo/map_repo_contract.dart';

@injectable
class GetRoutePointsUseCase {
  final MapRepoContract _repoContract;

  GetRoutePointsUseCase({required MapRepoContract repoContract})
    : _repoContract = repoContract;

  Future<BaseResponse<List<MapPathModel>>> call({
    required String coordinates,
  }) async {
    return _repoContract.getRoutePoints(coordinates: coordinates);
  }
}
