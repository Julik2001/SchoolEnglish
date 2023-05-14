import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class TaskTimer extends StatefulWidget {
  const TaskTimer({super.key, required this.time, this.onTimeIsOver});

  final Duration time;
  final void Function()? onTimeIsOver;

  @override
  State<TaskTimer> createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> {
  late Timer timer;
  late int timeLeft;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  void startTimer() {
    timeLeft = widget.time.inSeconds;
    timer = getOneSecondTimer();
  }

  Timer getOneSecondTimer() => Timer(const Duration(seconds: 1), timerTick);

  void timerTick() {
    setState(() {
      timeLeft--;
    });

    if (timeLeft == 0 && widget.onTimeIsOver != null) {
      widget.onTimeIsOver!();
    } else if (timeLeft > 0) {
      timer = getOneSecondTimer();
    }
  }

  String getTimeLeft() {
    var minutes = timeLeft ~/ 60;
    var seconds = timeLeft - minutes * 60;
    var minutesString = minutes < 10 ? "0$minutes" : minutes.toString();
    var secondsString = seconds < 10 ? "0$seconds" : seconds.toString();
    return "$minutesString:$secondsString";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.timer),
        const SizedBox(
          width: singleSpace,
        ),
        Text(getTimeLeft(), style: Theme.of(context).textTheme.headlineSmall)
      ],
    );
  }
}
