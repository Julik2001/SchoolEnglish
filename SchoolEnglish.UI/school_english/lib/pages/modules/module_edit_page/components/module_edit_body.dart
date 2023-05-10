import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/pages/components/add_item.dart';
import 'package:school_english/pages/components/base_item.dart';
import 'package:school_english/pages/components/base_page_body.dart';
import 'package:school_english/pages/modules/components/module_form.dart';

class ModuleEditBody extends StatefulWidget {
  const ModuleEditBody(
      {super.key,
      this.formKey,
      this.nameController,
      this.numberController,
      required this.moduleTasks,
      this.onAddTaskClick});

  final GlobalKey<FormState>? formKey;
  final TextEditingController? nameController;
  final TextEditingController? numberController;
  final List<Task> moduleTasks;
  final void Function()? onAddTaskClick;

  @override
  State<ModuleEditBody> createState() => _ModuleEditBodyState();
}

class _ModuleEditBodyState extends State<ModuleEditBody> {
  void showDeleteError() =>
      MessageBuilder.showError(context, "Ошибка при удалении задания!");

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: moduleEditHeader,
      description: moduleEditDescription,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModuleForm(
              formKey: widget.formKey,
              nameController: widget.nameController,
              numberController: widget.numberController),
          const SizedBox(
            height: singleSpace * 2,
          ),
          Text(
            moduleTasksHeader,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: singleSpace * 2,
          ),
          ...buildTasks(),
          AddItem(onClick: widget.onAddTaskClick),
        ],
      ),
    );
  }

  List<Widget> buildTasks() {
    List<Widget> taskItems = [];
    for (var task in widget.moduleTasks) {
      taskItems.add(Padding(
          padding: const EdgeInsets.all(singleSpace / 2),
          child: BaseItem(
            title: task.header,
            onEdit: () => context.go(Uri(
                path: "/$taskEditRoute",
                queryParameters: {"taskId": task.id}).toString()),
            onDelete: () async {
              var success = await Api.deleteTask(task.id!);
              if (!success) {
                showDeleteError();
                return;
              }
              setState(() {
                widget.moduleTasks.remove(task);
              });
            },
          )));
    }
    return taskItems;
  }
}
