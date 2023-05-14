import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/pages/components/task_timer.dart';
import 'package:school_english/pages/components/user_balance.dart';

class AppBarBuilder {
  static Future<String?> _getUserFullname() async {
    String? fullname = await LocalData.getFullname();
    if (Validator.isNullOrEmpty(fullname)) {
      fullname = await Api.getUserFullname();
      await LocalData.saveFullname(fullname ?? "");
    }
    return fullname;
  }

  static AppBar buildUserAppBar(BuildContext context,
      [void Function()? onBack]) {
    return AppBar(
      leading: onBack != null
          ? IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back))
          : null,
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
            onPressed: () => context.go("/$profileRoute"),
            icon: const Icon(Icons.person)),
      ],
    );
  }

  static Future<int?> _getBalance() async {
    return Api.getUserBalance();
  }

  static AppBar buildTaskAppBar(BuildContext context, Duration time,
      [void Function()? onTaskEnd]) {
    return AppBar(
      actions: [
        TaskTimer(
          time: time,
          onTimeIsOver: onTaskEnd,
        ),
        const SizedBox(
          width: singleSpace,
        ),
        FutureBuilder(
          future: _getBalance(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return UserBalance(balance: snapshot.requireData ?? 0);
            } else if (snapshot.hasError) {
              MessageBuilder.showError(context, "Не удалось загрузить баланс!");
              return Container();
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(
          width: singleSpace,
        ),
      ],
    );
  }
}
