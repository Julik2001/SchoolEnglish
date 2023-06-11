import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/pages/tasks/task_completion_page/components/answer/answer_form.dart';

class OpenedTask extends StatefulWidget {
  const OpenedTask(
      {super.key,
      required this.textContent,
      this.answerController,
      this.onAnswerChanged,
      this.multilineAnswer = true});

  final String? textContent;
  final TextEditingController? answerController;
  final void Function(String answer)? onAnswerChanged;
  final bool multilineAnswer;

  @override
  State<OpenedTask> createState() => _OpenedTaskState();
}

class _OpenedTaskState extends State<OpenedTask> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!Validator.isNullOrEmpty(widget.textContent))
          Expanded(
            child: Card(
              child: Container(
                constraints: const BoxConstraints.expand(),
                padding: const EdgeInsets.all(singleSpace),
                child: Text(
                  widget.textContent!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        if (!Validator.isNullOrEmpty(widget.textContent))
          const SizedBox(height: singleSpace * 2),
        Card(
          child: AnswerForm(
            formKey: formKey,
            answerController: widget.answerController,
            onAnswerChanged: (answer) {
              formKey.currentState!.save();
              if (formKey.currentState!.validate() &&
                  widget.onAnswerChanged != null) {
                widget.onAnswerChanged!(answer.trim());
              }
            },
            multiline: widget.multilineAnswer,
          ),
        ),
      ],
    );
  }
}
