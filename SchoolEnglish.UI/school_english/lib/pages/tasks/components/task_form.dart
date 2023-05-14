import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class TaskForm extends StatelessWidget {
  const TaskForm(
      {super.key,
      this.formKey,
      this.timeController,
      this.headerController,
      this.rewardController});

  final GlobalKey<FormState>? formKey;
  final TextEditingController? timeController;
  final TextEditingController? headerController;
  final TextEditingController? rewardController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: headerController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                  hintText: "Заголовок"),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите заголовок задания!";
                }
                return null;
              },
            ),
            const SizedBox(
              height: singleSpace,
            ),
            TextFormField(
              controller: timeController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.timer),
                  border: OutlineInputBorder(),
                  hintText: "Время выполнения",
                  suffixText: "мин."),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите время выполнения!";
                } else if (!Validator.validateStringNumber(value ?? "")) {
                  return "Введено не число";
                }
                return null;
              },
            ),
            const SizedBox(
              height: singleSpace,
            ),
            TextFormField(
              controller: rewardController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  hintText: "Награда"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите награду за задание!";
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
