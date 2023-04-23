import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
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
              loginHeader,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text(
              loginDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    TextFormField(
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
                ))
          ],
        ),
      ),
    );
  }
}
