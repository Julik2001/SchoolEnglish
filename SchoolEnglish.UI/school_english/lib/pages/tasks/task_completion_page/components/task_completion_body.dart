import 'package:flutter/material.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/models/task_part/taskpart.dart';
import 'package:school_english/pages/components/card_body.dart';
import 'package:school_english/pages/tasks/task_completion_page/components/closed_task.dart';
import 'package:school_english/pages/tasks/task_completion_page/components/information_dialog.dart';
import 'package:school_english/pages/tasks/task_completion_page/components/opened_task.dart';

class TaskCompletionBody extends StatefulWidget {
  const TaskCompletionBody(
      {super.key,
      required this.taskHeader,
      required this.taskParts,
      this.onAnswerChanged,
      this.onTaskComplete,
      this.onCluePaid});

  final String taskHeader;
  final List<TaskPart> taskParts;
  final void Function(String answer, String taskPartId)? onAnswerChanged;
  final void Function()? onTaskComplete;
  final void Function()? onCluePaid;

  @override
  State<TaskCompletionBody> createState() => _TaskCompletionBodyState();
}

class _TaskCompletionBodyState extends State<TaskCompletionBody> {
  TextEditingController answerController = TextEditingController();
  String closedAnswer = "";
  int currentTaskPartIndex = 0;
  bool isMultiline = false;

  void checkMultiline() async {
    isMultiline = await Api.checkTypeHasMultilineText(getCurrentTaskPart().id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkMultiline();
  }

  TaskPart getCurrentTaskPart() => widget.taskParts[currentTaskPartIndex];

  void showClue() => showDialog(
      context: context,
      builder: (BuildContext context) =>
          InformationDialog(information: getCurrentTaskPart().clueText));

  void showBalanceError() =>
      MessageBuilder.showError(context, "Недостаточно монет!");

  void showPaymentError() =>
      MessageBuilder.showError(context, "Оплата не удалась!");

  @override
  Widget build(BuildContext context) {
    TaskPart taskPart = getCurrentTaskPart();

    bool hasTextToRead = !Validator.isNullOrEmpty(taskPart.content.textToRead);
    bool hasImage = !Validator.isNullOrEmpty(taskPart.content.imagePath);
    bool hasAnswerVariants =
        !Validator.isNullOrEmpty(taskPart.content.answerVariants);

    return CardBody(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(singleSpace),
          child: Text(
            widget.taskHeader,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).canvasColor),
          ),
        ),
        Wrap(
          spacing: singleSpace,
          runSpacing: singleSpace,
          children: [
            ElevatedButton.icon(
                onPressed: () async {
                  var balance = await Api.getUserBalance() ?? 0;
                  if (balance < taskPart.clueCost) {
                    showBalanceError();
                    return;
                  }
                  var paid = await Api.payForClue(taskPart.id);
                  if (!paid) {
                    showPaymentError();
                    return;
                  }

                  if (widget.onCluePaid != null) {
                    widget.onCluePaid!();
                  }

                  showClue();
                },
                icon: const Icon(Icons.help),
                label:
                    Text("Получить подсказку за ${taskPart.clueCost} монет")),
            if (hasTextToRead)
              ElevatedButton.icon(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => InformationDialog(
                          information: taskPart.content.textToRead ?? "")),
                  icon: const Icon(Icons.description),
                  label: const Text("Показать текст"))
          ],
        ),
        const SizedBox(
          height: singleSpace,
        ),
        if (hasImage)
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(singleSpace),
                child: Image.network(
                    "$apiUrl/TaskPart/GetImage/?imagePath=${taskPart.content.imagePath}"),
              ),
            ),
          ),
        if (hasImage)
          const SizedBox(
            height: singleSpace,
          ),
        Expanded(
          child: hasAnswerVariants
              ? ClosedTask(
                  currentAnswer: closedAnswer,
                  answerVariants: taskPart.content.answerVariants!.split(";"),
                  textContent:
                      widget.taskParts[currentTaskPartIndex].content.text,
                  onAnswerChanged: (answer) {
                    setState(() {
                      closedAnswer = answer;
                    });
                    if (widget.onAnswerChanged != null) {
                      widget.onAnswerChanged!(answer, taskPart.id);
                    }
                  },
                )
              : OpenedTask(
                  textContent: taskPart.content.text,
                  answerController: answerController,
                  onAnswerChanged: (answer) {
                    if (widget.onAnswerChanged != null) {
                      widget.onAnswerChanged!(answer, taskPart.id);
                    }
                  },
                  multilineAnswer: isMultiline,
                ),
        ),
        const SizedBox(
          height: singleSpace * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentTaskPartIndex > 0)
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    currentTaskPartIndex--;
                    checkMultiline();
                    answerController.text = "";
                    closedAnswer = "";
                  });
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Назад"),
              ),
            const SizedBox(),
            if (currentTaskPartIndex < widget.taskParts.length - 1)
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    currentTaskPartIndex++;
                    checkMultiline();
                    answerController.text = "";
                    closedAnswer = "";
                  });
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Дальше"),
              ),
            if (currentTaskPartIndex == widget.taskParts.length - 1)
              ElevatedButton.icon(
                onPressed: widget.onTaskComplete,
                icon: const Icon(Icons.task_alt),
                label: const Text("Закончить"),
              ),
          ],
        )
      ]),
    );
  }
}
