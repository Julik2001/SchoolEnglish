import 'package:flutter/material.dart';
import 'package:school_english/pages/components/appbar_builder.dart';
import 'package:school_english/pages/modules/components/modules_body.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage({super.key, this.moduleId});

  final String? moduleId;

  @override
  State<ModulesPage> createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(context),
      body: ModulesBody(
        username: "Иванов Иван",
        moduleId: widget.moduleId,
      ),
    );
  }
}
