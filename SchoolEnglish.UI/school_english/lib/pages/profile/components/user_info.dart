import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/models/user/user.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium;
    TextStyle? bodyStyle = Theme.of(context).textTheme.bodyLarge;

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Фамилия:",
              style: titleStyle,
            ),
            const SizedBox(
              width: singleSpace,
            ),
            Text(
              user.surname,
              style: bodyStyle,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Имя:",
              style: titleStyle,
            ),
            const SizedBox(
              width: singleSpace,
            ),
            Text(
              user.name,
              style: bodyStyle,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Email:",
              style: titleStyle,
            ),
            const SizedBox(
              width: singleSpace,
            ),
            Text(
              user.email,
              style: bodyStyle,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Код учителя:",
              style: titleStyle,
            ),
            const SizedBox(
              width: singleSpace,
            ),
            Text(
              user.teacherCode,
              style: bodyStyle,
            ),
          ],
        ),
      ],
    );
  }
}
