import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/welcome/components/welcome_body.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const WelcomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.go("/$loginRoute")},
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
