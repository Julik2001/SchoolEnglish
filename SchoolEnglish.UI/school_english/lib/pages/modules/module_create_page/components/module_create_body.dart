import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/components/base_page_body.dart';
import 'package:school_english/pages/modules/components/module_form.dart';

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
      child: Column(
        children: [
          ModuleForm(
            formKey: formKey,
            nameController: nameController,
            numberController: numberController,
          )
        ],
      ),
    );
  }
}
