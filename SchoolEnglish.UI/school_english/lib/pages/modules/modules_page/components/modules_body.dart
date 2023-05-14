import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/models/module/module.dart';
import 'package:school_english/pages/components/add_item.dart';
import 'package:school_english/pages/components/base_item.dart';

class ModulesBody extends StatefulWidget {
  const ModulesBody(
      {super.key,
      required this.modules,
      required this.parentId,
      this.isModerator = false,
      this.onModuleClick,
      this.onEditModuleClick});

  final bool isModerator;
  final List<Module> modules;
  final String? parentId;
  final void Function(String? moduleId)? onModuleClick;
  final void Function()? onEditModuleClick;

  @override
  State<ModulesBody> createState() => _ModulesBodyState();
}

class _ModulesBodyState extends State<ModulesBody> {
  void onAddClick() => context.go(Uri(
      path: "/$moduleCreateRoute",
      queryParameters: {"parentId": widget.parentId}).toString());

  void showDeleteError() =>
      MessageBuilder.showError(context, "Ошибка при удалении модуля!");

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
        child: BaseItem(
          itemName: "модуль",
          title: Validator.isNullOrEmpty(widget.parentId)
              ? "${module.name} ${module.number}"
              : "${module.number} ${module.name}",
          onClick: () {
            if (widget.onModuleClick != null) {
              widget.onModuleClick!(module.id);
            }
          },
          onEdit: widget.isModerator
              ? () =>
                  context.go(Uri(path: "/$moduleEditRoute", queryParameters: {
                    "moduleId": module.id,
                  }).toString())
              : null,
          onDelete: widget.isModerator
              ? () async {
                  var success = await Api.deleteModule(module.id!);
                  if (!success) {
                    showDeleteError();
                    return;
                  }
                  setState(() {
                    widget.modules.remove(module);
                  });
                }
              : null,
        ),
      ));
    }
    return modules;
  }
}
