// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_student_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStudentReport _$TaskStudentReportFromJson(Map<String, dynamic> json) =>
    TaskStudentReport(
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      grade: json['grade'] as int,
      reward: json['reward'] as int,
    );

Map<String, dynamic> _$TaskStudentReportToJson(TaskStudentReport instance) =>
    <String, dynamic>{
      'correctAnswers': instance.correctAnswers,
      'wrongAnswers': instance.wrongAnswers,
      'grade': instance.grade,
      'reward': instance.reward,
    };
