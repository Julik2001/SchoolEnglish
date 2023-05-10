import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/components/base_page_body.dart';
import 'package:school_english/pages/tasks/components/task_form.dart';

class TaskCreateBody extends StatelessWidget {
  const TaskCreateBody({
    super.key,
    this.formKey,
    this.headerController,
    this.rewardController,
  });

  final GlobalKey<FormState>? formKey;
  final TextEditingController? headerController;
  final TextEditingController? rewardController;

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: taskCreateHeader,
      description: taskCreateDescription,
      child: TaskForm(
        formKey: formKey,
        headerController: headerController,
        rewardController: rewardController,
      ),
    );
  }
}
