import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/localdata.dart';

class AppBarBuilder {
  static Future<String?> _getUserFullname() async {
    String? fullname = await LocalData.getFullname();
    if (Validator.isNullOrEmpty(fullname)) {
      fullname = await Api.getUserFullname();
      await LocalData.saveFullname(fullname ?? "");
    }
    return fullname;
  }

  static AppBar buildUserAppBar(BuildContext context) {
    return AppBar(
      title: FutureBuilder(
        future: _getUserFullname(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data ?? "",
              style: Theme.of(context).textTheme.titleMedium,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      actions: [
        IconButton(
            onPressed: () => context.go("/$modulesRoute"),
            icon: const Icon(Icons.home)),
        IconButton(
            onPressed: () => context.go("/$profileRoute"),
            icon: const Icon(Icons.person)),
      ],
    );
  }
}
