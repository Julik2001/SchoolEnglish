// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskpart_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskPartContent _$TaskPartContentFromJson(Map<String, dynamic> json) =>
    TaskPartContent(
      id: json['id'] as String,
      text: json['text'] as String?,
      textToRead: json['textToRead'] as String?,
      answerVariants: json['answerVariants'] as String?,
      imagePath: json['imagePath'] as String?,
      audioPath: json['audioPath'] as String?,
      typeId: json['typeId'] as String,
      taskPartId: json['taskPartId'] as String,
    );

Map<String, dynamic> _$TaskPartContentToJson(TaskPartContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'textToRead': instance.textToRead,
      'answerVariants': instance.answerVariants,
      'imagePath': instance.imagePath,
      'audioPath': instance.audioPath,
      'typeId': instance.typeId,
      'taskPartId': instance.taskPartId,
    };
