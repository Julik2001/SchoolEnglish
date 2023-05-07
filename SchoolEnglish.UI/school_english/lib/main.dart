import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/pages/exercise/exercise_page.dart';
import 'package:school_english/pages/login/login_page.dart';
import 'package:school_english/pages/modules/module_edit_page/module_edit_page.dart';
import 'package:school_english/pages/modules/modules_page/modules_page.dart';
import 'package:school_english/pages/register/register_page.dart';
import 'package:school_english/pages/teacher_code/teacher_code_page.dart';
import 'package:school_english/pages/profile/profile_page.dart';
import 'package:school_english/pages/welcome/welcome_page.dart';

void main() {
  runApp(const SchoolEnglish());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: "/",
      builder: (context, state) {
        return const WelcomePage();
      },
      redirect: (context, state) async {
        var jwt = await LocalData.getJwt();
        var teacherCode = await LocalData.getTeacherCode();
        var roleIsModerator = await Api.checkRoleIsModerator();
        if (!Validator.isNullOrEmpty(jwt) &&
                !Validator.isNullOrEmpty(teacherCode) ||
            roleIsModerator) {
          return "/$modulesRoute";
        } else if (!Validator.isNullOrEmpty(jwt) &&
            Validator.isNullOrEmpty(teacherCode)) {
          return "/$teacherCodeRoute";
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: loginRoute,
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: registerRoute,
          builder: (context, state) {
            return const RegisterPage();
          },
        ),
      ]),
  GoRoute(
    path: "/$teacherCodeRoute",
    builder: (context, state) {
      return const TeacherCodePage();
    },
    redirect: (context, state) async {
      var teacherCode = await LocalData.getTeacherCode();
      var roleIsModerator = await Api.checkRoleIsModerator();
      if (!Validator.isNullOrEmpty(teacherCode) || roleIsModerator) {
        return "/$modulesRoute";
      }
      return null;
    },
  ),
  GoRoute(
    path: "/$modulesRoute",
    builder: (context, state) {
      return const ModulesPage();
    },
  ),
  GoRoute(
    path: "/$moduleEditRoute",
    builder: (context, state) {
      return ModuleEditPage(
        moduleId: state.queryParams["moduleId"],
        parentId: state.queryParams["parentId"],
      );
    },
  ),
  GoRoute(
    path: "/$exerciseRoute",
    builder: (context, state) {
      return const ExercisePage();
    },
  ),
  GoRoute(
    path: "/$profileRoute",
    builder: (context, state) {
      return const ProfilePage();
    },
  ),
]);

class SchoolEnglish extends StatelessWidget {
  const SchoolEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: primaryColor,
      ),
    );
  }
}
