import 'package:json_annotation/json_annotation.dart';

part 'metadata.g.dart';

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalItems")
  final int? totalItems;
  @JsonKey(name: "limit")
  final int? limit;

  Metadata({this.currentPage, this.totalPages, this.totalItems, this.limit});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
