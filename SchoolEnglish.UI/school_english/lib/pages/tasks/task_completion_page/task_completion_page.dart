import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:school_english/api.dart";
import "package:school_english/constants.dart";
import "package:school_english/helpers/appbar_builder.dart";
import "package:school_english/helpers/message_builder.dart";
import "package:school_english/helpers/validator.dart";
import "package:school_english/models/task/task.dart";
import "package:school_english/models/task_part/taskpart.dart";
import "package:school_english/models/user_answers/user_answer.dart";
import 'package:school_english/pages/error/error_page.dart';
import "package:school_english/pages/tasks/task_completion_page/components/task_completion_body.dart";

class TaskCompletionPage extends StatefulWidget {
  const TaskCompletionPage({super.key, required this.taskId});

  final String taskId;

  @override
  State<TaskCompletionPage> createState() => _TaskCompletionPageState();
}

class _TaskCompletionPageState extends State<TaskCompletionPage> {
  List<UserAnswer> userAnswers = [];
  late Future<Task?> task;
  late Future<List<TaskPart>> taskParts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    task = Api.getTask(widget.taskId);
    taskParts = Api.getTaskParts(widget.taskId);
  }

  void prepareUserAnswers(List<TaskPart> parts) {
    for (var part in parts) {
      userAnswers.add(UserAnswer(answer: "", taskPartId: part.id));
    }
  }

  void onTaskComplete() async {
    bool isSuccess = true;
    for (var userAnswer in userAnswers) {
      var answerId = await Api.createOrUpdateUserAnswer(userAnswer);
      isSuccess = isSuccess && !Validator.isNullOrEmpty(answerId);
    }
    if (isSuccess) {
      goToTaskReport();
    } else {
      showAnswersError();
    }
  }

  void goToTaskReport() => context.go(
      Uri(path: "/$taskReportRoute", queryParameters: {"taskId": widget.taskId})
          .toString());

  void showAnswersError() =>
      MessageBuilder.showError(context, "Не удалось отправить ответы!");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([task, taskParts]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var task = snapshot.requireData.first as Task?;
            var taskParts = snapshot.requireData.last as List<TaskPart>;
            prepareUserAnswers(taskParts);
            return Scaffold(
                appBar: AppBarBuilder.buildTaskAppBar(
                    context,
                    Duration(minutes: task?.timeInMinutes ?? 5),
                    onTaskComplete),
                body: TaskCompletionBody(
                  taskHeader: task?.header ?? "",
                  taskParts: taskParts,
                  onAnswerChanged: (answer, taskPartId) {
                    var userAnswer = userAnswers.firstWhere(
                        (element) => element.taskPartId == taskPartId);
                    var index = userAnswers.indexOf(userAnswer);
                    userAnswers[index] =
                        UserAnswer(answer: answer, taskPartId: taskPartId);
                  },
                  onTaskComplete: onTaskComplete,
                  onCluePaid: () => setState(() {}),
                ));
          } else if (snapshot.hasError) {
            MessageBuilder.showError(context, "Не удалось загрузить задание!");
            return const ErrorPage();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
