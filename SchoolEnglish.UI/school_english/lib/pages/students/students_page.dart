import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/appbar_builder.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/user/user.dart';
import 'package:school_english/pages/components/card_body.dart';
import 'package:school_english/pages/students/components/students_body.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  late Future<List<User>> students;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    students = Api.getStudents();
  }

  void goToTeacherReport(String studentId) => context.go(Uri(
      path: "/$teacherReportRoute",
      queryParameters: {"studentId": studentId}).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(context),
      body: CardBody(
        child: FutureBuilder(
          future: students,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StudentsBody(
                students: snapshot.requireData,
                onStudentClick: goToTeacherReport,
              );
            } else if (snapshot.hasError) {
              MessageBuilder.showError(context, "Что-то пошло не так");
              return Container();
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
