import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/pages/components/add_item.dart';
import 'package:school_english/pages/modules/modules_page/components/module_item.dart';

class ModulesBody extends StatefulWidget {
  const ModulesBody(
      {super.key,
      required this.modules,
      this.onModuleClick,
      this.isModerator = false});

  final List<Module> modules;
  final void Function(String? moduleId)? onModuleClick;
  final bool isModerator;

  @override
  State<ModulesBody> createState() => _ModulesBodyState();
}

class _ModulesBodyState extends State<ModulesBody> {
  void onAddClick() =>
      context.go(Uri(path: "/$moduleEditRoute", queryParameters: {
        "parentId":
            widget.modules.isNotEmpty ? widget.modules.first.parentId : null
      }).toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ...buildModulesItems(),
        if (widget.isModerator) AddItem(onClick: onAddClick),
      ],
    ));
  }

  List<Widget> buildModulesItems() {
    List<Widget> modules = [];
    for (var module in widget.modules) {
      modules.add(Padding(
        padding: const EdgeInsets.all(singleSpace / 2),
        child: ModuleItem(
          title: "${module.name} ${module.number}",
          onClick: () {
            if (widget.onModuleClick != null) {
              widget.onModuleClick!(module.id);
            }
          },
          onEdit: widget.isModerator
              ? () => context.go(Uri(
                      path: "/$moduleEditRoute",
                      queryParameters: {
                        "moduleId": module.id,
                        "parentId": module.parentId
                      }).toString())
              : null,
        ),
      ));
    }
    return modules;
  }
}
