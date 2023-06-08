import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/models/task/task.dart';
import 'package:school_english/pages/error/error_page.dart';
import 'package:school_english/pages/modules/module_edit_page/components/module_edit_body.dart';

class ModuleEditPage extends StatefulWidget {
  const ModuleEditPage({super.key, required this.moduleId});

  final String moduleId;

  @override
  State<ModuleEditPage> createState() => _ModuleEditPageState();
}

class _ModuleEditPageState extends State<ModuleEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _numberContoller = TextEditingController();
  late Future<Module?> module;
  late Future<List<Task>> tasks;
  String? parentId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    module = Api.getModule(widget.moduleId);
    tasks = Api.getTasks(widget.moduleId);
  }

  void updateModule() async {
    var module = Module(
      id: widget.moduleId,
      name: _nameContoller.text,
      number: _numberContoller.text,
      parentId: parentId,
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
        future: Future.wait([module, tasks]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var module = snapshot.requireData.first as Module?;
            _nameContoller.text = module != null ? module.name : "";
            _numberContoller.text = module != null ? module.number : "";
            parentId = module?.parentId;
            var tasks = snapshot.requireData.last as List<Task>;
            return ModuleEditBody(
              formKey: _formKey,
              nameController: _nameContoller,
              numberController: _numberContoller,
              moduleTasks: tasks,
              onAddTaskClick: () => context.go(Uri(
                  path: "/$taskCreateRoute",
                  queryParameters: {"moduleId": module?.id}).toString()),
            );
          } else if (snapshot.hasError) {
            return const ErrorPage();
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
            if (_formKey.currentState!.validate()) {
              updateModule();
            }
          },
          child: const Icon(Icons.save)),
    );
  }
}
