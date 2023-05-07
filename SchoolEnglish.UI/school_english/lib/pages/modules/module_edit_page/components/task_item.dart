import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.header, this.onClick});

  final String header;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onClick,
        child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(singleSpace),
          child: Row(
            children: [
              Text(header, style: Theme.of(context).textTheme.bodyLarge),
              const Expanded(
                  child: SizedBox(
                width: singleSpace,
              )),
              const Icon(Icons.edit),
            ],
          ),
        ),
      ),
    );
  }
}
