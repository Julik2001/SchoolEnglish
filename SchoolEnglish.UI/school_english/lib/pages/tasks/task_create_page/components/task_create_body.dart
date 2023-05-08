import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/pages/components/base_page_body.dart';

class TaskCreateBody extends StatelessWidget {
  const TaskCreateBody({
    super.key,
    this.formKey,
    this.headerController,
    this.rewardController,
  });

  final GlobalKey<FormState>? formKey;
  final TextEditingController? headerController;
  final TextEditingController? rewardController;

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
        header: taskCreateHeader,
        description: taskCreateDescription,
        child: Form(
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
                      return "Введите заголовок задания";
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
                      prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(),
                      hintText: "Награда"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (Validator.isNullOrEmpty(value)) {
                      return "Введите награду за задание!";
                    } else if (Validator.validateStringNumber(value!)) {
                      return "Введено не число!";
                    } else if (int.parse(value) < 0) {
                      return "Число не может быть отрицательным!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: singleSpace * 2,
                ),
              ],
            )));
  }
}
