import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/welcome/components/welcome_body.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WelcomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.go("/$loginRoute")},
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
