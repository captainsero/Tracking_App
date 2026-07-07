import 'package:json_annotation/json_annotation.dart';

part 'path_geometry_model.g.dart';

@JsonSerializable()
class PathGeometryModel {
  @JsonKey(name: 'coordinates')
  final List<List<double>>? coordinates;

  PathGeometryModel({this.coordinates});

  factory PathGeometryModel.fromJson(Map<String, dynamic> json) =>
      _$PathGeometryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PathGeometryModelToJson(this);
}
