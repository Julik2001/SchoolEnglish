import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/models/taskpart_content_type/content_type.dart';
import 'package:school_english/pages/components/base_page_body.dart';
import 'package:school_english/pages/task_part/components/taskpart_form.dart';
import 'package:school_english/pages/task_part/components/taskpart_content_form.dart';

class TaskPartEditBody extends StatelessWidget {
  const TaskPartEditBody(
      {super.key,
      this.taskPartformKey,
      this.contentTypeformKey,
      this.numberController,
      this.rightAnswerController,
      this.clueTextController,
      this.clueCostController,
      required this.types,
      this.textController,
      this.textToReadController,
      this.answerVariantsController,
      this.onTypeChanged,
      this.onImagePicked,
      this.onAudioPicked,
      this.typeId,
      this.imagePath,
      this.audioPath});

  final GlobalKey<FormState>? taskPartformKey;
  final GlobalKey<FormState>? contentTypeformKey;
  final TextEditingController? numberController;
  final TextEditingController? rightAnswerController;
  final TextEditingController? clueTextController;
  final TextEditingController? clueCostController;
  final List<TaskPartContentType> types;
  final TextEditingController? textController;
  final TextEditingController? textToReadController;
  final TextEditingController? answerVariantsController;
  final void Function(String typeId)? onTypeChanged;
  final void Function(File imageFile)? onImagePicked;
  final void Function(File audioFile)? onAudioPicked;
  final String? typeId;
  final String? imagePath;
  final String? audioPath;

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
        header: taskPartEditHeader,
        description: taskPartEditDescription,
        child: Column(
          children: [
            TaskPartForm(
              formKey: taskPartformKey,
              numberController: numberController,
              rightAnswerController: rightAnswerController,
              clueTextController: clueTextController,
              clueCostController: clueCostController,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            TaskPartContentForm(
              formKey: contentTypeformKey,
              types: types,
              textController: textController,
              textToReadController: textToReadController,
              answerVariantsController: answerVariantsController,
              onTypeChanged: onTypeChanged,
              onImagePicked: onImagePicked,
              onAudioPicked: onAudioPicked,
              typeId: typeId,
              imagePath: imagePath,
              audioPath: audioPath,
            ),
          ],
        ));
  }
}
