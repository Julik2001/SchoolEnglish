import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class BaseBody extends StatelessWidget {
  const BaseBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius * 2),
            topRight: Radius.circular(borderRadius * 2)),
      ),
      child: Container(
        constraints: const BoxConstraints.expand(),
        margin: const EdgeInsets.all(singleSpace),
        child: child,
      ),
    );
  }
}
