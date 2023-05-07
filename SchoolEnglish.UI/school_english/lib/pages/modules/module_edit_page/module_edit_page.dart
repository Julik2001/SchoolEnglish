import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/pages/modules/module_edit_page/components/module_edit_body.dart';

class ModuleEditPage extends StatefulWidget {
  const ModuleEditPage({super.key, this.moduleId, this.parentId});

  final String? moduleId;
  final String? parentId;

  @override
  State<ModuleEditPage> createState() => _ModuleEditPageState();
}

class _ModuleEditPageState extends State<ModuleEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _numberContoller = TextEditingController();
  late Future<Module?>? module;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    module =
        widget.moduleId != null ? Api.getModule(widget.moduleId ?? "") : null;
  }

  void updateModule() async {
    var module = Module(
      id: Validator.isNullOrEmpty(widget.moduleId) ? null : widget.moduleId,
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
      MessageBuilder.showError(context, "Ошибка при сохранении модуля!");

  void goToModulesPage() => context.go("/$modulesRoute");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goToModulesPage(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: module,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _nameContoller.text =
                snapshot.data != null ? snapshot.data!.name : "";
            _numberContoller.text =
                snapshot.data != null ? snapshot.data!.number : "";
            return ModuleEditBody(
              formKey: _formKey,
              nameController: _nameContoller,
              numberController: _numberContoller,
              moduleTasks: [],
            );
          } else if (snapshot.hasError) {
            MessageBuilder.showError(context, "Что-то пошло не так");
            return Container();
          } else if (snapshot.data == null) {
            return ModuleEditBody(
              formKey: _formKey,
              nameController: _nameContoller,
              numberController: _numberContoller,
              moduleTasks: [],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _formKey.currentState?.save();
            updateModule();
          },
          child: const Icon(Icons.save)),
    );
  }
}
