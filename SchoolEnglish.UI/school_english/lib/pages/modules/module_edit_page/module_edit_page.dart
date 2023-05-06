import 'package:flutter/material.dart';
import 'package:school_english/api.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/pages/components/appbar_builder.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            );
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Что-то пошло не так"),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
            return Container();
          } else if (snapshot.data == null) {
            return ModuleEditBody(
              formKey: _formKey,
              nameController: _nameContoller,
              numberController: _numberContoller,
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
          },
          child: const Icon(Icons.save)),
    );
  }
}
