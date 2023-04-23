import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
                constraints: const BoxConstraints.expand(),
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.menu_book,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: singleSpace * 2,
                    ),
                    Text(
                      workbook,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Colors.white, fontFamily: "Segoe Script"),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))),
        Expanded(
            child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(singleSpace * 2),
                  child: Text(
                    appDescription,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center,
                  ),
                )))
      ],
    );
  }
}
