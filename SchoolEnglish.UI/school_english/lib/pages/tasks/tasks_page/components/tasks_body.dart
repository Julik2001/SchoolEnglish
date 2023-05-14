import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/pages/components/base_item.dart';

class TasksBody extends StatefulWidget {
  const TasksBody({super.key, required this.tasks, this.onTaskClick});

  final List<Task> tasks;
  final void Function(String? taskId)? onTaskClick;

  @override
  State<TasksBody> createState() => _TasksBodyState();
}

class _TasksBodyState extends State<TasksBody> {
  void showDeleteError() =>
      MessageBuilder.showError(context, "Ошибка при удалении модуля!");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ...buildTasksItems(),
      ],
    ));
  }

  List<Widget> buildTasksItems() {
    List<Widget> tasks = [];
    for (var task in widget.tasks) {
      tasks.add(Padding(
        padding: const EdgeInsets.all(singleSpace / 2),
        child: BaseItem(
          itemName: "задача",
          title: task.header,
          onClick: () {
            if (widget.onTaskClick != null) {
              widget.onTaskClick!(task.id);
            }
          },
        ),
      ));
    }
    return tasks;
  }
}
