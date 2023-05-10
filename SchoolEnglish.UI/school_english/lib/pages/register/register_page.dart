import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/models/register/registerDto.dart';
import 'package:school_english/pages/register/components/register_body.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isTeacherUser = false;

  Future<void> register() async {
    var role =
        isTeacherUser ? await Api.getTeacherRole() : await Api.getStudentRole();

    if (role == null) return;

    var registerDto = RegisterDto(
        name: _nameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        roleId: role.id);

    var jwt = await Api.register(registerDto);
    if (Validator.isNullOrEmpty(jwt)) {
      showRegisterError();
      return;
    }

    await LocalData.saveJwt(jwt!);
    goToTeacherCodePage();
  }

  void goToTeacherCodePage() => context.go("/$teacherCodeRoute");

  void showRegisterError() =>
      MessageBuilder.showError(context, "Ошибка при регистрации!");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RegisterBody(
        formKey: _formKey,
        nameController: _nameController,
        surnameController: _surnameController,
        emailController: _emailController,
        passwordController: _passwordController,
        onRoleChanged: (value) => {isTeacherUser = value},
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              register();
            }
          },
          child: const Icon(Icons.arrow_forward)),
    );
  }
}
