// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherReport _$TeacherReportFromJson(Map<String, dynamic> json) =>
    TeacherReport(
      tasksCompleted: json['tasksCompleted'] as int,
      correctAnswersPercentage:
          (json['correctAnswersPercentage'] as num).toDouble(),
      averageGrade: json['averageGrade'] as int,
    );

Map<String, dynamic> _$TeacherReportToJson(TeacherReport instance) =>
    <String, dynamic>{
      'tasksCompleted': instance.tasksCompleted,
      'correctAnswersPercentage': instance.correctAnswersPercentage,
      'averageGrade': instance.averageGrade,
    };
