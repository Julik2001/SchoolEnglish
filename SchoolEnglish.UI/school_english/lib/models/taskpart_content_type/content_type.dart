import 'package:json_annotation/json_annotation.dart';

part 'content_type.g.dart';

@JsonSerializable()
class TaskPartContentType {
  final String id;
  final String name;

  const TaskPartContentType({
    required this.id,
    required this.name,
  });

  factory TaskPartContentType.fromJson(Map<String, dynamic> json) =>
      _$TaskPartContentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TaskPartContentTypeToJson(this);
}
