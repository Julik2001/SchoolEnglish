import 'package:flutter/material.dart';
import 'package:school_english/api.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/pages/components/appbar_builder.dart';
import 'package:school_english/pages/components/base_body.dart';
import 'package:school_english/pages/modules/modules_page/components/modules_body.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage({super.key, this.moduleId});

  final String? moduleId;

  @override
  State<ModulesPage> createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  late Future<List<Module>> modules;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.moduleId != null) {
      modules = Api.getSubmodules(widget.moduleId ?? "");
    } else {
      modules = Api.getModules();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(context),
      body: BaseBody(
        child: FutureBuilder(
          future: modules,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ModulesBody(
                modules: snapshot.requireData,
              );
            } else if (snapshot.hasData) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Что-то пошло не так"),
                backgroundColor: Theme.of(context).colorScheme.error,
              ));
              return Container();
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
