import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class ModuleForm extends StatelessWidget {
  const ModuleForm(
      {super.key, this.formKey, this.nameController, this.numberController});

  final GlobalKey<FormState>? formKey;
  final TextEditingController? nameController;
  final TextEditingController? numberController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                  hintText: "Название"),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите название модуля";
                }
                return null;
              },
            ),
            const SizedBox(
              height: singleSpace,
            ),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                  hintText: "Номер"),
              keyboardType: TextInputType.text,
            ),
          ],
        ));
  }
}
