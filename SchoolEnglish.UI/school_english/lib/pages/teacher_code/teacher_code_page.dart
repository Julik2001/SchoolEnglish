import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/teacher_code/components/teacher_code_body.dart';

class TeacherCodePage extends StatefulWidget {
  const TeacherCodePage({super.key, required this.isTeacherUser});

  final bool isTeacherUser;

  @override
  State<TeacherCodePage> createState() => _TeacherCodePageState();
}

class _TeacherCodePageState extends State<TeacherCodePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TeacherCodeBody(
        isTeacherUser: widget.isTeacherUser,
        teacherCode: "123-456",
        formKey: _formKey,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!widget.isTeacherUser && _formKey.currentState!.validate()) {
              context.go("/$modulesRoute");
            }
          },
          child: const Icon(Icons.arrow_forward)),
    );
  }
}
