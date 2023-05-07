import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/pages/login/components/login_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();

  void login(String email, String password) async {
    var jwt = await Api.login(email, password);
    if (jwt != null) {
      LocalData.saveJwt(jwt);
      goToTeacherCodePage();
    } else {
      showLoginError();
    }
  }

  void goToTeacherCodePage() => context.go("/$teacherCodeRoute");

  void showLoginError() => MessageBuilder.showError(
      context, "Неверный адрес электронной почты или пароль!");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LoginBody(
        formKey: _formKey,
        emailController: _emailContoller,
        passwordController: _passwordContoller,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _formKey.currentState?.save();
            if (_formKey.currentState!.validate()) {
              login(_emailContoller.text, _passwordContoller.text);
            }
          },
          child: const Icon(Icons.arrow_forward)),
    );
  }
}
