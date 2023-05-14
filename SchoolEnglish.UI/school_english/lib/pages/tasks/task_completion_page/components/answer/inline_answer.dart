import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class InlineAnswer extends StatelessWidget {
  const InlineAnswer(
      {super.key,
      required this.answer,
      required this.answerDropped,
      required this.answerLength,
      this.onClick});

  final bool answerDropped;
  final int answerLength;
  final String answer;
  final void Function()? onClick;

  String getEmptyAnswer() {
    String answer = " ";
    while (answer.length < answerLength) {
      answer += " ";
    }
    return answer;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: answerDropped ? null : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
                color: answerDropped
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).shadowColor)),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: answerDropped && onClick != null ? onClick : null,
          child: Padding(
            padding: const EdgeInsets.all(singleSpace),
            child: Text(
              answerDropped ? answer : getEmptyAnswer(),
              style: answerDropped
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).hoverColor.withOpacity(0)),
            ),
          ),
        ));
  }
}
