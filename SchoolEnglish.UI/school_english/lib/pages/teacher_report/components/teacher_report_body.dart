import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/models/reports/teacher_report.dart';
import 'package:school_english/models/user/user.dart';
import 'package:school_english/pages/components/base_page_body.dart';

class TeacherReportBody extends StatelessWidget {
  const TeacherReportBody(
      {super.key, required this.student, required this.report});

  final User student;
  final TeacherReport report;

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: "Результаты ученика",
      description: "${student.surname} ${student.name}\n${student.email}",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: singleSpace,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.checklist,
                size: taskReportIconSize * 0.4,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: singleSpace,
              ),
              Text(
                "Выполнено заданий - ${report.tasksCompleted}",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          const SizedBox(
            height: singleSpace,
          ),
          Wrap(
            runSpacing: singleSpace,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: taskReportIconSize * 0.4,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: singleSpace,
              ),
              Text(
                "Правильных ответов - ${report.correctAnswersPercentage.toStringAsFixed(2)} %",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          const SizedBox(
            height: singleSpace,
          ),
          Wrap(
            runSpacing: singleSpace,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.grade,
                size: taskReportIconSize * 0.4,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: singleSpace,
              ),
              Text(
                "Средняя оценка - ${report.averageGrade}",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ],
      ),
    );
  }
}
