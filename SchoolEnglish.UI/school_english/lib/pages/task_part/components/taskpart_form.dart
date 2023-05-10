import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class TaskPartForm extends StatelessWidget {
  const TaskPartForm(
      {super.key,
      this.formKey,
      this.numberController,
      this.rightAnswerController,
      this.clueTextController,
      this.clueCostController});

  final GlobalKey<FormState>? formKey;
  final TextEditingController? numberController;
  final TextEditingController? rightAnswerController;
  final TextEditingController? clueTextController;
  final TextEditingController? clueCostController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                  hintText: "Номер"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: singleSpace,
            ),
            TextFormField(
              controller: rightAnswerController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                  hintText: "Верный ответ"),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите верный ответ!";
                }
                return null;
              },
            ),
            const SizedBox(
              height: singleSpace,
            ),
            TextFormField(
              controller: clueTextController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                  hintText: "Подсказка"),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите текст подсказки!";
                }
                return null;
              },
            ),
            const SizedBox(
              height: singleSpace,
            ),
            TextFormField(
              controller: clueCostController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  hintText: "Стоимость подсказки"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите стоимость подсказки!";
                } else if (!Validator.validateStringNumber(value!)) {
                  return "Введено не число!";
                } else if (int.parse(value) < 0) {
                  return "Число не может быть отрицательным!";
                }
                return null;
              },
            ),
          ],
        ));
  }
}
