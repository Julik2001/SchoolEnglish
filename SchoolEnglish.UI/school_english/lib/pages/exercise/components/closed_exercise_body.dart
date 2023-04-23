import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/components/base_body.dart';

class ClosedExerciseBody extends StatefulWidget {
  const ClosedExerciseBody({super.key});

  @override
  State<ClosedExerciseBody> createState() => _ClosedExerciseBodyState();
}

class _ClosedExerciseBodyState extends State<ClosedExerciseBody> {
  bool answerDropped = false;
  String currentAnswer = "Answer";

  @override
  Widget build(BuildContext context) {
    return BaseBody(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(singleSpace),
          child: Text(
            "Exercise name",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).canvasColor),
          ),
        ),
        Expanded(
            child: Card(
          child: Container(
            constraints: BoxConstraints.expand(),
            padding: const EdgeInsets.all(singleSpace),
            child: Text.rich(TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: <InlineSpan>[
                TextSpan(text: "One word is missing in"),
                WidgetSpan(
                    child: DragTarget<String>(
                  onAccept: (data) {
                    setState(() {
                      currentAnswer = data;
                      answerDropped = true;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Card(
                        color: answerDropped
                            ? null
                            : Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            side: BorderSide(
                                color: answerDropped
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).shadowColor)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(borderRadius),
                          onTap: answerDropped
                              ? () => setState(() {
                                    answerDropped = false;
                                  })
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(singleSpace),
                            child: Text(
                              currentAnswer,
                              style: answerDropped
                                  ? Theme.of(context).textTheme.bodyLarge
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .hoverColor
                                              .withOpacity(0)),
                            ),
                          ),
                        ));
                  },
                )),
                TextSpan(text: "this sentence."),
              ],
            )),
          ),
        )),
        const SizedBox(height: singleSpace * 2),
        Expanded(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(singleSpace),
            child: Text(
              "Choose the correct answer:",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).canvasColor),
            ),
          ),
          Wrap(children: getVariants(4)),
        ])),
      ],
    ));
  }

  List<Widget> getVariants(int count) {
    List<Widget> variants = [];
    for (var i = 0; i < count; i++) {
      variants.add(
        Draggable<String>(
          data: "Answer ${i + 1}",
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(singleSpace),
            child: Text(
              "Answer ${i + 1}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )),
          feedback: Card(
              child: Padding(
            padding: const EdgeInsets.all(singleSpace),
            child: Text(
              "Answer ${i + 1}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )),
          childWhenDragging: Card(
              color: Theme.of(context).hoverColor,
              child: Padding(
                padding: const EdgeInsets.all(singleSpace),
                child: Text(
                  "Answer ${i + 1}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).hoverColor.withOpacity(0)),
                ),
              )),
        ),
      );
    }
    return variants;
  }

  Widget getAnswerVariants(int itemCount, int countPerLine) {
    List<Widget> variants = [];
    for (var i = 0; i < itemCount; i++) {
      variants.add(
        Card(
            child: Padding(
          padding: const EdgeInsets.all(singleSpace),
          child: Text(
            "Answer ${i + 1}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )),
      );
    }

    List<Widget> rows = [];
    int currentCountPerLine = 0;
    for (var i = 0; i < variants.length; i++) {
      //rows.add(variants.getRange(start, end))
    }
    return Row();
  }
}
