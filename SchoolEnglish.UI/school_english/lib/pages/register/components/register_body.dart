import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody(
      {super.key,
      required this.formKey,
      required this.nameController,
      required this.surnameController,
      required this.emailController,
      required this.passwordController,
      this.onRoleChanged});

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(bool value)? onRoleChanged;

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
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: surnameController,
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
                      controller: nameController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          hintText: "Имя"),
                      keyboardType: TextInputType.name,
                      validator: (name) {
                        if (Validator.isNullOrEmpty(name)) {
                          return "Введите имя!";
                        } else if (!Validator.validateName(name!)) {
                          return "Недопустимая имя!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: singleSpace,
                    ),
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
                        } else if (passwordController.text != password) {
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

                        if (onRoleChanged != null) {
                          onRoleChanged!(isTeacher!);
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
