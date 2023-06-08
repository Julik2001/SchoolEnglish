import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/appbar_builder.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/models/reports/teacher_report.dart';
import 'package:school_english/models/user/user.dart';
import 'package:school_english/pages/teacher_report/components/teacher_report_body.dart';

class TeacherReportPage extends StatefulWidget {
  const TeacherReportPage({super.key, required this.studentId});

  final String studentId;

  @override
  State<TeacherReportPage> createState() => _TeacherReportPageState();
}

class _TeacherReportPageState extends State<TeacherReportPage> {
  late Future<TeacherReport?> report;
  late Future<User?> student;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    student = Api.getUserInfoById(widget.studentId);
    report = Api.getTeacherReport(widget.studentId);
  }

  void goToStudents() => context.go("/$studentsRoute");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.buildUserAppBar(context, goToStudents),
      body: FutureBuilder(
        future: Future.wait([student, report]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var student = snapshot.requireData.first as User;
            var report = snapshot.requireData.last as TeacherReport;
            return TeacherReportBody(student: student, report: report);
          } else if (snapshot.hasError) {
            MessageBuilder.showError(context, "Не удалось загрузить отчет!");
            return Container();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
