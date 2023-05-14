// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String?,
      moduleId: json['moduleId'] as String,
      header: json['header'] as String,
      timeInMinutes: json['timeInMinutes'] as int,
      reward: json['reward'] as int,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'moduleId': instance.moduleId,
      'header': instance.header,
      'timeInMinutes': instance.timeInMinutes,
      'reward': instance.reward,
    };
