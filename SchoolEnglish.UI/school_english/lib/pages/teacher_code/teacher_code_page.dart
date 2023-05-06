import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/teacher_code/components/teacher_code_body.dart';

class TeacherCodePage extends StatefulWidget {
  const TeacherCodePage({super.key});

  @override
  State<TeacherCodePage> createState() => _TeacherCodePageState();
}

class _TeacherCodePageState extends State<TeacherCodePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  String? _teacherCode;
  bool userIsTeacher = false;
  bool isLoading = true;

  void getData() async {
    userIsTeacher = await Api.checkRoleIsTeacher();
    if (userIsTeacher) {
      _teacherCode = await Api.getTeacherCode();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  void updateTeacherCode() async {
    await Api.updateTeacherCode(_codeController.text);
    goToModulesPage();
  }

  void goToModulesPage() => context.go("/$modulesRoute");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TeacherCodeBody(
              userIsTeacher: userIsTeacher,
              formKey: _formKey,
              teacherCode: _teacherCode,
              codeController: _codeController,
            ),
      floatingActionButton: !isLoading
          ? FloatingActionButton(
              onPressed: () {
                if (!userIsTeacher && _formKey.currentState!.validate()) {
                  updateTeacherCode();
                } else if (userIsTeacher) {
                  goToModulesPage();
                }
              },
              child: const Icon(Icons.arrow_forward))
          : null,
    );
  }
}
