import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/pages/components/add_item.dart';
import 'package:school_english/pages/components/base_page_body.dart';
import 'package:school_english/pages/modules/module_edit_page/components/task_item.dart';

class ModuleEditBody extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BasePageBody(
      header: moduleEditHeader,
      description: moduleEditDescription,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        border: OutlineInputBorder(),
                        hintText: "Название"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (Validator.isNullOrEmpty(value)) {
                        return "Введите название модуля";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: singleSpace,
                  ),
                  TextFormField(
                    controller: numberController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                        hintText: "Номер"),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: singleSpace * 2,
                  ),
                ],
              )),
          Text(
            moduleTasksHeader,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: singleSpace * 2,
          ),
          ...buildTasks(),
          AddItem(onClick: onAddTaskClick),
        ],
      ),
    );
  }

  List<Widget> buildTasks() {
    List<Widget> taskItems = [];
    for (var task in moduleTasks) {
      taskItems.add(Padding(
          padding: const EdgeInsets.all(singleSpace / 2),
          child: TaskItem(header: task.header)));
    }
    return taskItems;
  }
}
