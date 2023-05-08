import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class BasePageBody extends StatelessWidget {
  const BasePageBody(
      {super.key, required this.header, required this.description, this.child});

  final String header;
  final String description;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      margin: const EdgeInsets.all(singleSpace),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
