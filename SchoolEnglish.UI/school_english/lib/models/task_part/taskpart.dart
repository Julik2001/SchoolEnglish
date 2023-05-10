import 'package:json_annotation/json_annotation.dart';
import 'package:school_english/models/taskpart_content/taskpart_content.dart';

part 'taskpart.g.dart';

@JsonSerializable()
class TaskPart {
  final String id;
  final String number;
  final String rightAnswer;
  final String clueText;
  final int clueCost;
  final TaskPartContent content;
  final String taskId;

  const TaskPart(
      {required this.id,
      required this.number,
      required this.rightAnswer,
      required this.clueText,
      required this.clueCost,
      required this.content,
      required this.taskId});

  factory TaskPart.fromJson(Map<String, dynamic> json) =>
      _$TaskPartFromJson(json);

  Map<String, dynamic> toJson() => _$TaskPartToJson(this);
}
