import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task_part/taskpart.dart';
import 'package:school_english/models/task_part/taskpart_dto.dart';
import 'package:school_english/models/taskpart_content_type/content_type.dart';
import 'package:school_english/pages/task_part/taskpart_edit_page/components/taskpart_edit_body.dart';

class TaskPartEditPage extends StatefulWidget {
  const TaskPartEditPage({super.key, required this.taskPartId});

  final String taskPartId;

  @override
  State<TaskPartEditPage> createState() => _TaskPartEditPageState();
}

class _TaskPartEditPageState extends State<TaskPartEditPage> {
  Future<TaskPart?>? taskPart;
  String? taskId;
  final GlobalKey<FormState> _taskPartformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contentTypeformKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _rightAnswerController = TextEditingController();
  final TextEditingController _clueTextController = TextEditingController();
  final TextEditingController _clueCostController = TextEditingController();
  late Future<List<TaskPartContentType>>? types;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textToReadController = TextEditingController();
  final TextEditingController _answerVariantsController =
      TextEditingController();
  String? currentTypeId;
  File? imageFile;
  File? audioFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    taskPart = Api.getTaskPart(widget.taskPartId);
    types = Api.getTaskPartContentTypes();
  }

  void updateTaskPart() async {
    var taskPart = TaskPartDto(
        id: widget.taskPartId,
        number: _numberController.text.trim(),
        rightAnswer: _rightAnswerController.text.trim(),
        clueText: _clueTextController.text.trim(),
        clueCost: int.parse(_clueCostController.text),
        text: _textController.text.trim(),
        textToRead: _textToReadController.text.trim(),
        answerVariants: _answerVariantsController.text.trim(),
        taskId: taskId!,
        typeId: currentTypeId!);

    var taskPartId =
        await Api.createOrUpdateTaskPart(taskPart, imageFile, audioFile);
    if (taskPartId != null) {
      setState(() {});
      goToTaskEditPage();
    } else {
      showUpdateError();
    }
  }

  void showUpdateError() =>
      MessageBuilder.showError(context, "Ошибка при сохранении части задания!");

  void goToTaskEditPage() => context.go(
      Uri(path: "/$taskEditRoute", queryParameters: {"taskId": taskId})
          .toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goToTaskEditPage(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: Future.wait([taskPart!, types!]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var taskPart = snapshot.requireData.first as TaskPart?;
            if (taskPart != null) {
              taskId = taskPart.taskId;
              currentTypeId = taskPart.content.typeId;
              _numberController.text = taskPart.number;
              _rightAnswerController.text = taskPart.rightAnswer;
              _clueTextController.text = taskPart.clueText;
              _clueCostController.text = taskPart.clueCost.toString();
              _textController.text = taskPart.content.text ?? "";
              _textToReadController.text = taskPart.content.textToRead ?? "";
              _answerVariantsController.text =
                  taskPart.content.answerVariants ?? "";
            }
            var types = snapshot.requireData.last as List<TaskPartContentType>;

            return TaskPartEditBody(
              taskPartformKey: _taskPartformKey,
              contentTypeformKey: _contentTypeformKey,
              numberController: _numberController,
              rightAnswerController: _rightAnswerController,
              clueTextController: _clueTextController,
              clueCostController: _clueCostController,
              types: types,
              textController: _textController,
              textToReadController: _textToReadController,
              answerVariantsController: _answerVariantsController,
              onTypeChanged: (typeId) => {currentTypeId = typeId},
              onImagePicked: (imageFile) => {this.imageFile = imageFile},
              onAudioPicked: (audioFile) => {this.audioFile = audioFile},
              typeId: taskPart?.content.typeId,
              imagePath: taskPart?.content.imagePath,
              audioPath: taskPart?.content.audioPath,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _taskPartformKey.currentState?.save();
            _contentTypeformKey.currentState?.save();
            if (_taskPartformKey.currentState!.validate() &&
                _contentTypeformKey.currentState!.validate()) {
              updateTaskPart();
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
