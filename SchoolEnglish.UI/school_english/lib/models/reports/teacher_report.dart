import 'package:json_annotation/json_annotation.dart';

part 'teacher_report.g.dart';

@JsonSerializable()
class TeacherReport {
  final int tasksCompleted;
  final double correctAnswersPercentage;
  final int averageGrade;

  const TeacherReport(
      {required this.tasksCompleted,
      required this.correctAnswersPercentage,
      required this.averageGrade});

  factory TeacherReport.fromJson(Map<String, dynamic> json) =>
      _$TeacherReportFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherReportToJson(this);
}
