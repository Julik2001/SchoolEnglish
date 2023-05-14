import 'package:json_annotation/json_annotation.dart';

part 'user_answer.g.dart';

@JsonSerializable()
class UserAnswer {
  final String answer;
  final String taskPartId;

  const UserAnswer({required this.answer, required this.taskPartId});

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$UserAnswerToJson(this);
}
