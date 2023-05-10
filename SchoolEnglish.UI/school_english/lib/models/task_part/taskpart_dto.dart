import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'taskpart_dto.g.dart';

@JsonSerializable()
class TaskPartDto {
  final String? id;
  final String number;
  final String rightAnswer;
  final String clueText;
  final int clueCost;
  final String taskId;
  final String? text;
  final String? textToRead;
  final String? answerVariants;
  final String typeId;

  const TaskPartDto({
    this.id,
    required this.number,
    required this.rightAnswer,
    required this.clueText,
    required this.clueCost,
    required this.taskId,
    this.text,
    this.textToRead,
    this.answerVariants,
    required this.typeId,
  });

  factory TaskPartDto.fromJson(Map<String, dynamic> json) =>
      _$TaskPartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskPartDtoToJson(this);
}
