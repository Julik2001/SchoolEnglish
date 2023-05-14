import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class InformationDialog extends StatelessWidget {
  const InformationDialog({super.key, required this.information});

  final String information;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
                child: Padding(
              padding: const EdgeInsets.all(singleSpace),
              child: Text(information),
            )),
          ],
        ),
      ),
      actions: [
        TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            label: const Text("Закрыть"))
      ],
    );
  }
}
