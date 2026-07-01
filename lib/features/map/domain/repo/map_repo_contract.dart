import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/map/data/models/map_path_model.dart';

abstract class MapRepoContract {
  Future<BaseResponse<List<MapPathModel>>> getRoutePoints({
    required String coordinates,
  });
}
