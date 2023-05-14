import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class UserBalance extends StatelessWidget {
  const UserBalance({super.key, required this.balance});

  final int balance;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.monetization_on),
        const SizedBox(
          width: singleSpace,
        ),
        Text(
          balance.toString(),
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}
