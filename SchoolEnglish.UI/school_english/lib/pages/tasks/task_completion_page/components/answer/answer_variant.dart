import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class AnswerVariant extends StatelessWidget {
  const AnswerVariant(
      {super.key, required this.answerText, this.isDragging = false});

  final String answerText;
  final bool isDragging;

  TextStyle? getTextStyle(BuildContext context) {
    var style = Theme.of(context).textTheme.bodyLarge;
    return isDragging
        ? style?.copyWith(color: Theme.of(context).hoverColor.withOpacity(0))
        : style;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: isDragging ? Theme.of(context).hoverColor : null,
        child: Padding(
            padding: const EdgeInsets.all(singleSpace),
            child: Text(
              answerText,
              style: getTextStyle(context),
            )));
  }
}
