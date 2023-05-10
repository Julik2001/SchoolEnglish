// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskpart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskPartDto _$TaskPartDtoFromJson(Map<String, dynamic> json) => TaskPartDto(
      id: json['id'] as String?,
      number: json['number'] as String,
      rightAnswer: json['rightAnswer'] as String,
      clueText: json['clueText'] as String,
      clueCost: json['clueCost'] as int,
      taskId: json['taskId'] as String,
      text: json['text'] as String?,
      textToRead: json['textToRead'] as String?,
      answerVariants: json['answerVariants'] as String?,
      typeId: json['typeId'] as String,
    );

Map<String, dynamic> _$TaskPartDtoToJson(TaskPartDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'rightAnswer': instance.rightAnswer,
      'clueText': instance.clueText,
      'clueCost': instance.clueCost,
      'taskId': instance.taskId,
      'text': instance.text,
      'textToRead': instance.textToRead,
      'answerVariants': instance.answerVariants,
      'typeId': instance.typeId,
    };
