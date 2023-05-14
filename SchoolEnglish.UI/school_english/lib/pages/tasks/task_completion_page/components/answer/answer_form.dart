import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class AnswerForm extends StatelessWidget {
  const AnswerForm(
      {super.key,
      this.formKey,
      this.answerController,
      this.onAnswerChanged,
      this.multiline = false});

  final GlobalKey<FormState>? formKey;
  final TextEditingController? answerController;
  final void Function(String answer)? onAnswerChanged;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(singleSpace),
      child: Form(
          key: formKey,
          child: TextFormField(
            controller: answerController,
            onChanged: (value) {
              if (onAnswerChanged != null) {
                onAnswerChanged!(value);
              }
            },
            maxLines: multiline ? 5 : 2,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.abc),
                border: OutlineInputBorder(),
                hintText: "Ответ"),
            keyboardType:
                multiline ? TextInputType.multiline : TextInputType.text,
            validator: (value) {
              if (Validator.isNullOrEmpty(value)) {
                return "Введите ответ!";
              }
              return null;
            },
          )),
    );
  }
}
