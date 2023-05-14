import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/pages/tasks/task_completion_page/components/answer/answer_variant.dart';
import 'package:school_english/pages/tasks/task_completion_page/components/answer/inline_answer.dart';

class ClosedTask extends StatefulWidget {
  const ClosedTask(
      {super.key,
      required this.currentAnswer,
      required this.answerVariants,
      this.textContent,
      this.onAnswerChanged});

  final String currentAnswer;
  final List<String> answerVariants;
  final String? textContent;
  final void Function(String answer)? onAnswerChanged;

  @override
  State<ClosedTask> createState() => _ClosedTaskState();
}

class _ClosedTaskState extends State<ClosedTask> {
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
                child: Text.rich(buildTaskContent(context)),
              ),
            ),
          ),
        if (!Validator.isNullOrEmpty(widget.textContent))
          const SizedBox(height: singleSpace * 2),
        Expanded(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(singleSpace),
              child: Text(
                answerVariantsHeader,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).canvasColor),
              ),
            ),
            Wrap(children: buildAnswerVariants()),
          ]),
        ),
      ],
    );
  }

  int getMaxAnswerLength() {
    var maxLength = widget.answerVariants.map((e) => e.length).reduce(max);
    if (maxLength < 3) {
      maxLength = 3;
    }
    return maxLength;
  }

  InlineSpan buildTaskContent(BuildContext context) {
    bool answerDropped = !Validator.isNullOrEmpty(widget.currentAnswer);
    var textParts = widget.textContent?.split("<answer>") ?? [];

    return TextSpan(
      style: Theme.of(context).textTheme.bodyLarge,
      children: <InlineSpan>[
        if (textParts.isNotEmpty) TextSpan(text: textParts.first),
        WidgetSpan(
            child: DragTarget<String>(
          onAccept: (data) {
            if (widget.onAnswerChanged != null) {
              widget.onAnswerChanged!(data);
            }
            setState(() {
              answerDropped = true;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return InlineAnswer(
              answer: getAnswerText(widget.currentAnswer),
              answerDropped: answerDropped,
              answerLength: getMaxAnswerLength(),
              onClick: () {
                if (widget.onAnswerChanged != null) {
                  widget.onAnswerChanged!("");
                }
                setState(() {
                  answerDropped = false;
                });
              },
            );
          },
        )),
        if (textParts.length > 1) TextSpan(text: textParts.last),
      ],
    );
  }

  String getAnswerText(String text) {
    var answerText = text;
    if (answerText.length < 3) {
      answerText = " $answerText ";
    }
    return answerText;
  }

  List<Widget> buildAnswerVariants() {
    List<Widget> variants = [];
    for (var answerVariant in widget.answerVariants) {
      variants.add(
        Draggable<String>(
          data: answerVariant,
          feedback: AnswerVariant(answerText: getAnswerText(answerVariant)),
          childWhenDragging: AnswerVariant(
              answerText: getAnswerText(answerVariant), isDragging: true),
          child: AnswerVariant(answerText: getAnswerText(answerVariant)),
        ),
      );
    }
    return variants;
  }
}
