import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody(
      {super.key, required this.formKey, this.onIsTeacherUserChanged});

  final GlobalKey<FormState> formKey;
  final void Function(bool value)? onIsTeacherUserChanged;

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _passwordController = TextEditingController();
  bool? isTeacher = false;

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
              registerHeader,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text(
              registerDescription,
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
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          hintText: "Фамилия"),
                      keyboardType: TextInputType.name,
                      validator: (surname) {
                        if (Validator.isNullOrEmpty(surname)) {
                          return "Введите фамилию!";
                        } else if (!Validator.validateName(surname!)) {
                          return "Недопустимая фаимилия!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: singleSpace,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          hintText: "Имя"),
                      keyboardType: TextInputType.name,
                      validator: (name) {
                        if (Validator.isNullOrEmpty(name)) {
                          return "Введите фамилию!";
                        } else if (!Validator.validateName(name!)) {
                          return "Недопустимая фаимилия!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: singleSpace,
                    ),
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
                      controller: _passwordController,
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
                      height: singleSpace,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          border: OutlineInputBorder(),
                          hintText: "Повторите пароль"),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (password) {
                        if (Validator.isNullOrEmpty(password)) {
                          return "Введите пароль!";
                        } else if (_passwordController.text != password) {
                          return "Пароли не совпадают!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: singleSpace,
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.group),
                          border: OutlineInputBorder(),
                          hintText: "Ваша роль"),
                      items: const [
                        DropdownMenuItem<String>(
                            value: "Учитель", child: Text("Учитель")),
                        DropdownMenuItem<String>(
                            value: "Ученик(ца)", child: Text("Ученик(ца)")),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        isTeacher = value == "Учитель";

                        if (widget.onIsTeacherUserChanged != null) {
                          widget.onIsTeacherUserChanged!(isTeacher!);
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Выберите роль!";
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
                        const Text(goToLoginButtonLabel),
                        TextButton(
                            onPressed: () {
                              context.go("/$loginRoute");
                            },
                            child: const Text(loginButtonLabel))
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
