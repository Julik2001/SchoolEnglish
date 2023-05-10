import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task_part/taskpart_dto.dart';
import 'package:school_english/models/taskpart_content_type/content_type.dart';
import 'package:school_english/pages/task_part/taskpart_create_page/components/taskpart_create_body.dart';

class TaskPartCreatePage extends StatefulWidget {
  const TaskPartCreatePage({super.key, required this.taskId});

  final String taskId;

  @override
  State<TaskPartCreatePage> createState() => _TaskPartCreatePageState();
}

class _TaskPartCreatePageState extends State<TaskPartCreatePage> {
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

    types = Api.getTaskPartContentTypes();
  }

  void createTaskPart() async {
    var taskPart = TaskPartDto(
        number: _numberController.text,
        rightAnswer: _rightAnswerController.text,
        clueText: _clueTextController.text,
        clueCost: int.parse(_clueCostController.text),
        text: _textController.text,
        textToRead: _textToReadController.text,
        answerVariants: _answerVariantsController.text,
        taskId: widget.taskId,
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
      MessageBuilder.showError(context, "Ошибка при создании части задания!");

  void goToTaskEditPage() => context.go(
      Uri(path: "/$taskEditRoute", queryParameters: {"taskId": widget.taskId})
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
        future: types,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TaskPartCreateBody(
              taskPartformKey: _taskPartformKey,
              contentTypeformKey: _contentTypeformKey,
              numberController: _numberController,
              rightAnswerController: _rightAnswerController,
              clueTextController: _clueTextController,
              clueCostController: _clueCostController,
              types: snapshot.requireData,
              textController: _textController,
              textToReadController: _textToReadController,
              answerVariantsController: _answerVariantsController,
              onTypeChanged: (typeId) => {currentTypeId = typeId},
              onImagePicked: (imageFile) => {this.imageFile = imageFile},
              onAudioPicked: (audioFile) => {this.audioFile = audioFile},
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
              createTaskPart();
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
