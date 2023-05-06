import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class ModuleItem extends StatelessWidget {
  const ModuleItem({super.key, required this.title, this.onClick, this.onEdit});

  final String title;
  final void Function()? onClick;
  final void Function()? onEdit;

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
        onTap: onEdit ?? onClick,
        child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(singleSpace),
          child: Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              const Expanded(
                  child: SizedBox(
                width: singleSpace,
              )),
              if (onEdit != null) const Icon(Icons.edit),
            ],
          ),
        ),
      ),
    );
  }
}
