import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/register/components/register_body.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isTeacherUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RegisterBody(
        formKey: _formKey,
        onIsTeacherUserChanged: (value) => {isTeacherUser = value},
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Все верно!")));
              context.go("/register/$teacherCodeRoute/$isTeacherUser");
            }
          },
          child: const Icon(Icons.arrow_forward)),
    );
  }
}
