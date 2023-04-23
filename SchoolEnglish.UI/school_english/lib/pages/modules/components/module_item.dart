import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class ModuleItem extends StatelessWidget {
  const ModuleItem({super.key, required this.title, this.onClick});

  final String title;
  final void Function()? onClick;

  static double getTitleHeight(context) {
    var font = Theme.of(context).textTheme.bodyLarge;
    return font != null && font.height != null
        ? font.height! + singleSpace * 3
        : singleSpace * 4;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onClick,
        child: Container(
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints.expand(height: getTitleHeight(context)),
          margin: const EdgeInsets.all(singleSpace),
          child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}
