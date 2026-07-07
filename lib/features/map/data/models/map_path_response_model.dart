import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/map/data/models/map_path_model.dart';

part 'map_path_response_model.g.dart';

@JsonSerializable()
class MapPathResponseModel {
  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'routes')
  final List<MapPathModel>? mapPaths;

  MapPathResponseModel({this.code, this.mapPaths});

  factory MapPathResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MapPathResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapPathResponseModelToJson(this);
}
