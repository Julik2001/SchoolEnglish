import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/pages/modules/modules_page/components/module_add_item.dart';
import 'package:school_english/pages/modules/modules_page/components/module_item.dart';

class ModulesBody extends StatefulWidget {
  const ModulesBody({super.key, required this.modules});

  final List<Module> modules;

  @override
  State<ModulesBody> createState() => _ModulesBodyState();
}

class _ModulesBodyState extends State<ModulesBody> {
  bool roleIsModerator = false;

  void getPermissions() async {
    roleIsModerator = await Api.checkRoleIsModerator();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPermissions();
  }

  void onAddClick() =>
      context.go(Uri(path: "/$modulesRoute/$moduleEditRoute", queryParameters: {
        "parentId":
            widget.modules.isNotEmpty ? widget.modules.first.parentId : null
      }).toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ...buildModulesItems(),
        if (roleIsModerator) ModuleAddItem(onClick: onAddClick),
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
          onClick: () =>
              context.go("/$modulesRoute/$submodulesRoute/${module.id}"),
          onEdit: roleIsModerator
              ? () => context.go(Uri(
                      path: "/$modulesRoute/$moduleEditRoute",
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
