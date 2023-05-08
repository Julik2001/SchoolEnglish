import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/pages/components/base_page_body.dart';

class ModuleCreateBody extends StatelessWidget {
  const ModuleCreateBody({
    super.key,
    this.formKey,
    this.nameController,
    this.numberController,
  });

  final GlobalKey<FormState>? formKey;
  final TextEditingController? nameController;
  final TextEditingController? numberController;

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: moduleCreateHeader,
      description: moduleCreateDescription,
      child: Form(
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
                    return "Введите название модуля!";
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
              const SizedBox(
                height: singleSpace * 2,
              ),
            ],
          )),
    );
  }
}
