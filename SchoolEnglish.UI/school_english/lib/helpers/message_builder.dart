import 'package:flutter/material.dart';

class MessageBuilder {
  static void showInformation(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));

  static void showError(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
}
