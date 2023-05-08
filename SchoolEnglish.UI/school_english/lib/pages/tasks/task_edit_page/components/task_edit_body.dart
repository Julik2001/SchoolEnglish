import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/components/add_item.dart';
import 'package:school_english/pages/components/base_page_body.dart';

class TaskEditBody extends StatelessWidget {
  const TaskEditBody(
      {super.key,
      required this.formKey,
      this.headerController,
      this.rewardController});

  final GlobalKey<FormState> formKey;
  final TextEditingController? headerController;
  final TextEditingController? rewardController;

  void addTaskClick() async {}

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: taskEditHeader,
      description: taskEditDescription,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: headerController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        border: OutlineInputBorder(),
                        hintText: "Название"),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: singleSpace,
                  ),
                  TextFormField(
                    controller: rewardController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                        hintText: "Номер"),
                    keyboardType: TextInputType.number,
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
          const AddItem(),
        ],
      ),
    );
  }

  List<Widget> buildTasks() {
    List<Widget> taskItems = [];
    // for (var task in moduleTasks) {
    //   taskItems.add(Padding(
    //       padding: const EdgeInsets.all(singleSpace / 2),
    //       child: TaskItem(header: task.header)));
    // }
    return taskItems;
  }
}
