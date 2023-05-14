import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/helpers/appbar_builder.dart';
import 'package:school_english/pages/components/card_body.dart';
import 'package:school_english/pages/modules/modules_page/components/modules_body.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage({super.key, this.moduleId});

  final String? moduleId;

  @override
  State<ModulesPage> createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  late Future<List<Module>> modules;
  String? moduleId;
  List<String?> parents = [];
  bool roleIsModerator = false;
  bool hasSubmodules = false;

  void getModules() {
    if (moduleId != null) {
      modules = Api.getSubmodules(moduleId!);
    } else {
      modules = Api.getModules();
    }
  }

  void getPermissions() async {
    roleIsModerator = await Api.checkRoleIsModerator();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    moduleId = widget.moduleId;
    getModules();
    getPermissions();
  }

  void goToTasks(String moduleId) => context.go(
      Uri(path: "/$tasksRoute", queryParameters: {"moduleId": moduleId})
          .toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(
          context,
          moduleId != null
              ? () {
                  setState(() {
                    moduleId = parents.last;
                    parents.removeLast();
                    getModules();
                  });
                }
              : null),
      body: CardBody(
        child: FutureBuilder(
          future: modules,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ModulesBody(
                isModerator: roleIsModerator,
                parentId: moduleId,
                modules: snapshot.requireData,
                onModuleClick: (newModuleId) async {
                  hasSubmodules = await Api.checkSubmodules(newModuleId ?? "");
                  if (hasSubmodules || roleIsModerator) {
                    setState(() {
                      parents.add(moduleId);
                      moduleId = newModuleId;
                      getModules();
                    });
                  } else {
                    goToTasks(newModuleId ?? "");
                  }
                },
              );
            } else if (snapshot.hasError) {
              MessageBuilder.showError(context, "Что-то пошло не так");
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
