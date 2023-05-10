import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/pages/tasks/task_create_page/components/task_create_body.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key, required this.moduleId});

  final String moduleId;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _headerContoller = TextEditingController();
  final TextEditingController _rewardContoller = TextEditingController();

  void createTask() async {
    var task = Task(
      id: null,
      header: _headerContoller.text,
      reward: int.parse(_rewardContoller.text),
      moduleId: widget.moduleId,
    );

    var taskId = await Api.createOrUpdateTask(task);
    if (taskId != null) {
      setState(() {});
      goToModuleEditPage();
    } else {
      showUpdateError();
    }
  }

  void showUpdateError() =>
      MessageBuilder.showError(context, "Ошибка при создании модуля!");

  void goToModuleEditPage() => context.go(Uri(
      path: "/$moduleEditRoute",
      queryParameters: {"moduleId": widget.moduleId}).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goToModuleEditPage(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: TaskCreateBody(
        formKey: _formKey,
        headerController: _headerContoller,
        rewardController: _rewardContoller,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _formKey.currentState?.save();
            if (_formKey.currentState!.validate()) {
              createTask();
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
