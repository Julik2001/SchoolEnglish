import 'package:json_annotation/json_annotation.dart';

part 'task_student_report.g.dart';

@JsonSerializable()
class TaskStudentReport {
  final int correctAnswers;
  final int wrongAnswers;
  final int grade;
  final int reward;

  const TaskStudentReport(
      {required this.correctAnswers,
      required this.wrongAnswers,
      required this.grade,
      required this.reward});

  factory TaskStudentReport.fromJson(Map<String, dynamic> json) =>
      _$TaskStudentReportFromJson(json);

  Map<String, dynamic> toJson() => _$TaskStudentReportToJson(this);
}
