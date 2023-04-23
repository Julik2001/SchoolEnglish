import 'package:flutter/material.dart';
import 'package:school_english/pages/components/appbar_builder.dart';
import 'package:school_english/pages/exercise/components/closed_exercise_body.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(context),
      body: const ClosedExerciseBody(),
    );
  }
}
