import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class BaseItem extends StatelessWidget {
  const BaseItem(
      {super.key,
      required this.title,
      this.itemName,
      this.onClick,
      this.onEdit,
      this.onDelete});

  final String title;
  final String? itemName;
  final void Function()? onClick;
  final void Function()? onEdit;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onClick,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(singleSpace),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                ),
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
        if (onDelete != null)
          Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Подтвердите удаление"),
                        content: Text(
                            "Вы точно хотите удалить этот ${itemName ?? "объект"}?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onDelete!();
                              },
                              child: const Text("Да")),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Нет")),
                        ],
                      )),
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(singleSpace),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
