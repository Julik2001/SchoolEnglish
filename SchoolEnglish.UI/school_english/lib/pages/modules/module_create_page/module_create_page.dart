import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/pages/modules/module_create_page/components/module_create_body.dart';

class ModuleCreatePage extends StatefulWidget {
  const ModuleCreatePage({super.key, this.parentId});

  final String? parentId;

  @override
  State<ModuleCreatePage> createState() => _ModuleCreatePageState();
}

class _ModuleCreatePageState extends State<ModuleCreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _numberContoller = TextEditingController();

  void createModule() async {
    var module = Module(
      id: null,
      name: _nameContoller.text,
      number: _numberContoller.text,
      parentId:
          Validator.isNullOrEmpty(widget.parentId) ? null : widget.parentId,
    );

    var moduleId = await Api.createOrUpdateModule(module);
    if (moduleId != null) {
      setState(() {});
      goToModulesPage();
    } else {
      showUpdateError();
    }
  }

  void showUpdateError() =>
      MessageBuilder.showError(context, "Ошибка при создании модуля!");

  void goToModulesPage() => context.go("/$modulesRoute");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goToModulesPage(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ModuleCreateBody(
        formKey: _formKey,
        nameController: _nameContoller,
        numberController: _numberContoller,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _formKey.currentState?.save();
            if (_formKey.currentState!.validate()) {
              createModule();
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
