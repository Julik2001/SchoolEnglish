import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/login/components/login_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LoginBody(formKey: _formKey),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                if (_formKey.currentState!.validate())
                  {context.go("/$modulesRoute")}
              },
          child: const Icon(Icons.arrow_forward)),
    );
  }
}
