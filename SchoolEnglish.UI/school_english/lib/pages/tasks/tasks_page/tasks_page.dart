import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/helpers/appbar_builder.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/pages/components/card_body.dart';
import 'package:school_english/pages/tasks/tasks_page/components/tasks_body.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key, required this.moduleId});

  final String moduleId;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late Future<List<Task>> tasks;
  bool hasSubmodules = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tasks = Api.getTasks(widget.moduleId);
  }

  void goToTaskCompletion(String taskId) => context.go(
      Uri(path: "/$taskCompletionRoute", queryParameters: {"taskId": taskId})
          .toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(
          context, () => context.go("/$modulesRoute")),
      body: CardBody(
        child: FutureBuilder(
          future: tasks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TasksBody(
                tasks: snapshot.requireData,
                onTaskClick: (taskId) {
                  if (!Validator.isNullOrEmpty(taskId)) {
                    goToTaskCompletion(taskId!);
                  }
                },
              );
            } else if (snapshot.hasError) {
              MessageBuilder.showError(
                  context, "Не удалось загрузить задания!");
              return Container();
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
