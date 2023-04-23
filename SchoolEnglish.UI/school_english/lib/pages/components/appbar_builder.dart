import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class AppBarBuilder {
  static AppBar buildUserAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Иванов Иван",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(singleSpace * 2),
          child: Icon(Icons.person),
        )
      ],
    );
  }
}
