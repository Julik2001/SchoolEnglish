import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class ModuleItem extends StatelessWidget {
  const ModuleItem({super.key, required this.title, this.onClick, this.onEdit});

  final String title;
  final void Function()? onClick;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onClick,
              onLongPress: onEdit,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(singleSpace),
                child:
                    Text(title, style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
          ),
        ),
        if (onEdit != null)
          Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onEdit,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(singleSpace),
                child: const Icon(Icons.edit),
              ),
            ),
          ),
      ],
    );
  }
}
