import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

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
                ))
          ],
        ),
      ),
    );
  }
}
