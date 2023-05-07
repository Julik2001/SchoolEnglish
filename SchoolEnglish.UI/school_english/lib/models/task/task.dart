import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String id;
  final String moduleId;
  final String header;
  final int reward;

  const Task(
      {required this.id,
      required this.moduleId,
      required this.header,
      required this.reward});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
