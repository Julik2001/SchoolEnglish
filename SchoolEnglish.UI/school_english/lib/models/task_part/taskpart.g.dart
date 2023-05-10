// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskpart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskPart _$TaskPartFromJson(Map<String, dynamic> json) => TaskPart(
      id: json['id'] as String,
      number: json['number'] as String,
      rightAnswer: json['rightAnswer'] as String,
      clueText: json['clueText'] as String,
      clueCost: json['clueCost'] as int,
      content:
          TaskPartContent.fromJson(json['content'] as Map<String, dynamic>),
      taskId: json['taskId'] as String,
    );

Map<String, dynamic> _$TaskPartToJson(TaskPart instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'rightAnswer': instance.rightAnswer,
      'clueText': instance.clueText,
      'clueCost': instance.clueCost,
      'content': instance.content,
      'taskId': instance.taskId,
    };
