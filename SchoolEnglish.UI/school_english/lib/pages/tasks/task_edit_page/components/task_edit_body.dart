import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task_part/taskpart.dart';
import 'package:school_english/pages/components/add_item.dart';
import 'package:school_english/pages/components/base_item.dart';
import 'package:school_english/pages/components/base_page_body.dart';
import 'package:school_english/pages/tasks/components/task_form.dart';

class TaskEditBody extends StatefulWidget {
  const TaskEditBody(
      {super.key,
      required this.formKey,
      this.headerController,
      this.rewardController,
      required this.taskParts,
      this.onAddTaskPartClick});

  final GlobalKey<FormState>? formKey;
  final TextEditingController? headerController;
  final TextEditingController? rewardController;
  final List<TaskPart> taskParts;
  final void Function()? onAddTaskPartClick;

  @override
  State<TaskEditBody> createState() => _TaskEditBodyState();
}

class _TaskEditBodyState extends State<TaskEditBody> {
  void showDeleteError() =>
      MessageBuilder.showError(context, "Ошибка при удалении части задания!");

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: taskEditHeader,
      description: taskEditDescription,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskForm(
            formKey: widget.formKey,
            headerController: widget.headerController,
            rewardController: widget.rewardController,
          ),
          const SizedBox(
            height: singleSpace * 2,
          ),
          Text(
            taskPartsHeader,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: singleSpace * 2,
          ),
          ...buildTaskParts(),
          AddItem(
            onClick: widget.onAddTaskPartClick,
          ),
        ],
      ),
    );
  }

  List<Widget> buildTaskParts() {
    List<Widget> taskItems = [];
    for (var taskPart in widget.taskParts) {
      taskItems.add(Padding(
          padding: const EdgeInsets.all(singleSpace / 2),
          child: BaseItem(
            title: "${taskPart.number} ${taskPart.content.text ?? ""}",
            onEdit: () => context.go(Uri(
                path: "/$taskPartEditRoute",
                queryParameters: {"taskPartId": taskPart.id}).toString()),
            onDelete: () async {
              var success = await Api.deleteTaskPart(taskPart.id);
              if (!success) {
                showDeleteError();
                return;
              }
              setState(() {
                widget.taskParts.remove(taskPart);
              });
            },
          )));
    }
    return taskItems;
  }
}
