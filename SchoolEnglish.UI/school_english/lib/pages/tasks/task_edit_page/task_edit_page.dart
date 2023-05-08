import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/pages/error_page/error_page.dart';
import 'package:school_english/pages/tasks/task_edit_page/components/task_edit_body.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key, required this.taskId, required this.moduleId});

  final String? taskId;
  final String moduleId;

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _headerContoller = TextEditingController();
  final TextEditingController _rewardContoller = TextEditingController();
  late Future<Task?>? task;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    task = widget.taskId != null ? Api.getTask(widget.taskId!) : null;
  }

  void goToModulesPage() => context.go(Uri(
      path: "/$moduleEditRoute",
      queryParameters: {"moduleId": widget.moduleId}).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goToModulesPage(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: Future.wait([task!]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var task = snapshot.requireData.first as Task?;
            _headerContoller.text = task != null ? task.header : "";
            _rewardContoller.text = task != null ? task.reward.toString() : "";
            //var tasks = snapshot.requireData.last as List<Task>;
            return TaskEditBody(
              formKey: _formKey,
              headerController: _headerContoller,
              rewardController: _rewardContoller,
            );
          } else if (snapshot.hasError) {
            return const ErrorPage();
          } else if (snapshot.data == null) {
            return TaskEditBody(
              formKey: _formKey,
              headerController: _headerContoller,
              rewardController: _rewardContoller,
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
            //updateModule();
          },
          child: const Icon(Icons.save)),
    );
  }
}
