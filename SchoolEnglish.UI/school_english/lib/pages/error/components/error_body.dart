import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.sentiment_very_dissatisfied, size: errorIconSize),
        const SizedBox(
          height: singleSpace,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: singleSpace,
        ),
        TextButton(
            onPressed: () => context.go("/"), child: const Text("На главную"))
      ]),
    );
  }
}
