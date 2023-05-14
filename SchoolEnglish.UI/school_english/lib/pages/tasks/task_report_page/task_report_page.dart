import 'package:flutter/material.dart';
import 'package:school_english/api.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/reports/task_student_report.dart';
import 'package:school_english/pages/tasks/task_report_page/components/task_report_body.dart';

class TaskReportPage extends StatefulWidget {
  const TaskReportPage({super.key, required this.taskId});

  final String taskId;

  @override
  State<TaskReportPage> createState() => _TaskReportPageState();
}

class _TaskReportPageState extends State<TaskReportPage> {
  late Future<TaskStudentReport?> report;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    report = Api.getTaskStudentReport(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: report,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TaskReportBody(
              correctAnswers: snapshot.requireData?.correctAnswers ?? 0,
              wrongAnswers: snapshot.requireData?.wrongAnswers ?? 0,
              grade: snapshot.requireData?.grade ?? 0,
              reward: snapshot.requireData?.reward ?? 0,
            );
          } else if (snapshot.hasError) {
            MessageBuilder.showError(
                context, "Не удалось загрузить отчет по заданию!");
            return Container();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
