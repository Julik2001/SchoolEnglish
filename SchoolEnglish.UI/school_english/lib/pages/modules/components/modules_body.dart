import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/components/base_body.dart';
import 'package:school_english/pages/modules/components/module_item.dart';

class ModulesBody extends StatefulWidget {
  const ModulesBody({super.key, required this.username, this.moduleId});

  final String username;
  final String? moduleId;

  @override
  State<ModulesBody> createState() => _ModulesBodyState();
}

class _ModulesBodyState extends State<ModulesBody> {
  @override
  Widget build(BuildContext context) {
    return BaseBody(
        child: SingleChildScrollView(
      child: Column(
          children:
              widget.moduleId == null ? getAllModules() : getSubModules()),
    ));
  }

  List<Widget> getAllModules() {
    List<Widget> modules = [];
    for (var i = 0; i < 15; i++) {
      modules.add(Padding(
        padding: const EdgeInsets.all(singleSpace / 2),
        child: ModuleItem(
          title: "Module ${i + 1}",
          onClick: () => context.go("/$modulesRoute/$i"),
        ),
      ));
    }
    return modules;
  }

  List<Widget> getSubModules() {
    List<Widget> submodules = [];
    for (var i = 0; i < 15; i++) {
      submodules.add(Padding(
        padding: const EdgeInsets.all(singleSpace / 2),
        child: ModuleItem(
          title: "Submodule ${i + 1}",
          onClick: () => context.go("/$exerciseRoute"),
        ),
      ));
    }
    return submodules;
  }
}
