import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/pages/components/base_page_body.dart';

class LoginBody extends StatelessWidget {
  const LoginBody(
      {super.key,
      required this.formKey,
      this.emailController,
      this.passwordController});

  final GlobalKey<FormState> formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: loginHeader,
      description: loginDescription,
      child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (Validator.isNullOrEmpty(email)) {
                    return "Введите адрес электронной почты!";
                  } else if (!Validator.validateEmail(email!)) {
                    return "Некорректный адрес электронной почты!";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: singleSpace,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    border: OutlineInputBorder(),
                    hintText: "Пароль"),
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (password) {
                  if (Validator.isNullOrEmpty(password)) {
                    return "Введите пароль!";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: singleSpace * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(goToRegisterButtonLabel),
                  TextButton(
                      onPressed: () {
                        context.go("/$registerRoute");
                      },
                      child: const Text(registerButtonLabel))
                ],
              )
            ],
          )),
    );
  }
}
