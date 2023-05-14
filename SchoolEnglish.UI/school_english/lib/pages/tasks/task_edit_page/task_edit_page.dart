import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/models/task_part/taskpart.dart';
import 'package:school_english/pages/error_page/error_page.dart';
import 'package:school_english/pages/tasks/task_edit_page/components/task_edit_body.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key, required this.taskId});

  final String taskId;

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _headerContoller = TextEditingController();
  final TextEditingController _timeContoller = TextEditingController();
  final TextEditingController _rewardContoller = TextEditingController();
  late Future<Task?>? task;
  late Future<List<TaskPart>>? taskParts;
  String moduleId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    task = Api.getTask(widget.taskId);
    taskParts = Api.getTaskParts(widget.taskId);
  }

  void updateTask() async {
    var task = Task(
      id: widget.taskId,
      header: _headerContoller.text,
      timeInMinutes: int.parse(_timeContoller.text),
      reward: int.parse(_rewardContoller.text),
      moduleId: moduleId,
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
      MessageBuilder.showError(context, "Ошибка при сохранении задания!");

  void goToModuleEditPage() => context.go(
      Uri(path: "/$moduleEditRoute", queryParameters: {"moduleId": moduleId})
          .toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goToModuleEditPage(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: Future.wait([task!, taskParts!]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var task = snapshot.requireData.first as Task?;
            _headerContoller.text = task != null ? task.header : "";
            _timeContoller.text =
                task != null ? task.timeInMinutes.toString() : "";
            _rewardContoller.text = task != null ? task.reward.toString() : "";
            moduleId = task?.moduleId ?? "";
            var taskParts = snapshot.requireData.last as List<TaskPart>;
            return TaskEditBody(
              formKey: _formKey,
              headerController: _headerContoller,
              timeController: _timeContoller,
              rewardController: _rewardContoller,
              taskParts: taskParts,
              onAddTaskPartClick: () => context.go(Uri(
                  path: "/$taskPartCreateRoute",
                  queryParameters: {"taskId": task?.id}).toString()),
            );
          } else if (snapshot.hasError) {
            return const ErrorPage();
          } else if (snapshot.data == null) {
            return TaskEditBody(
              formKey: _formKey,
              headerController: _headerContoller,
              timeController: _timeContoller,
              rewardController: _rewardContoller,
              taskParts: [],
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
            _formKey.currentState?.save();
            if (_formKey.currentState!.validate()) {
              updateTask();
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
