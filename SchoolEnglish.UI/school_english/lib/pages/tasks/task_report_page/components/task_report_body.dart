import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';

class TaskReportBody extends StatelessWidget {
  const TaskReportBody(
      {super.key,
      required this.correctAnswers,
      required this.wrongAnswers,
      required this.grade,
      required this.reward});

  final int correctAnswers;
  final int wrongAnswers;
  final int grade;
  final int reward;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
            child: SizedBox(
          height: singleSpace,
        )),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              buildHeaderIcon(),
              const SizedBox(
                height: singleSpace,
              ),
              Text(
                "Твоя оценка - $grade",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: singleSpace * 2,
              ),
              if (reward > 0)
                Text(
                  "За это задание вы получили $reward монет",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: taskReportIconSize * 0.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: singleSpace,
                ),
                Text(
                  "Верных ответов - $correctAnswers",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.dangerous,
                  size: taskReportIconSize * 0.5,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(
                  width: singleSpace,
                ),
                Text(
                  "Неверных ответов - $wrongAnswers",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ]),
        ),
        Expanded(
          child: Center(
              child: ElevatedButton.icon(
            icon: const Icon(Icons.home),
            label: const Text("На главную"),
            onPressed: () => context.go("/"),
          )),
        ),
      ],
    );
  }

  Widget buildHeaderIcon() {
    IconData iconData = Icons.sentiment_neutral;
    switch (grade) {
      case 5:
        {
          iconData = Icons.sentiment_very_satisfied;
          break;
        }
      case 4:
        {
          iconData = Icons.sentiment_satisfied;
          break;
        }
      case 3:
        {
          iconData = Icons.sentiment_neutral;
          break;
        }
      case 2:
        {
          iconData = Icons.sentiment_dissatisfied;
          break;
        }
    }
    return Icon(
      iconData,
      size: taskReportIconSize,
    );
  }
}
