import 'package:json_annotation/json_annotation.dart';
import 'package:school_english/models/taskpart_content_type/content_type.dart';

part 'taskpart_content.g.dart';

@JsonSerializable()
class TaskPartContent {
  final String id;
  final String? text;
  final String? textToRead;
  final String? answerVariants;
  final String? imagePath;
  final String? audioPath;
  final String typeId;
  final String taskPartId;

  const TaskPartContent(
      {required this.id,
      this.text,
      this.textToRead,
      this.answerVariants,
      this.imagePath,
      this.audioPath,
      required this.typeId,
      required this.taskPartId});

  factory TaskPartContent.fromJson(Map<String, dynamic> json) =>
      _$TaskPartContentFromJson(json);

  Map<String, dynamic> toJson() => _$TaskPartContentToJson(this);
}
