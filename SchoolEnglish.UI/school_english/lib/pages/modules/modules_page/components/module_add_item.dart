import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class ModuleAddItem extends StatelessWidget {
  const ModuleAddItem({super.key, this.onClick});

  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(singleSpace / 2),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onClick,
          child: Container(
            margin: const EdgeInsets.all(singleSpace),
            child: const Center(
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
