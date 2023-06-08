import 'package:flutter/material.dart';
import 'package:school_english/pages/error/components/error_body.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.message = "Что-то пошло не так"});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorBody(message: message),
    );
  }
}
