import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/map/data/models/path_geometry_model.dart';

part 'map_path_model.g.dart';

@JsonSerializable()
class MapPathModel {
  @JsonKey(name: 'geometry')
  final PathGeometryModel? geometry;

  @JsonKey(name: 'distance')
  final double? distance;

  @JsonKey(name: 'duration')
  final double? duration;

  MapPathModel({this.geometry, this.distance, this.duration});

  factory MapPathModel.fromJson(Map<String, dynamic> json) =>
      _$MapPathModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapPathModelToJson(this);
}
