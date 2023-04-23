import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/pages/exercise/exercise_page.dart';
import 'package:school_english/pages/login/login_page.dart';
import 'package:school_english/pages/modules/modules_page.dart';
import 'package:school_english/pages/register/register_page.dart';
import 'package:school_english/pages/teacher_code/teacher_code_page.dart';
import 'package:school_english/welcome/welcome_page.dart';

void main() {
  runApp(const SchoolEnglish());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: "/",
      builder: (context, state) {
        return const WelcomePage();
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
          routes: <RouteBase>[
            GoRoute(
              path: "$teacherCodeRoute/:isTeacherUser",
              builder: (context, state) {
                return TeacherCodePage(
                    isTeacherUser: state.params["isTeacherUser"] == "true");
              },
            ),
          ],
        ),
      ]),
  GoRoute(
    path: "/$modulesRoute",
    builder: (context, state) {
      return const ModulesPage();
    },
    routes: <RouteBase>[
      GoRoute(
        path: ":moduleId",
        builder: (context, state) {
          return ModulesPage(moduleId: state.params["moduleId"]);
        },
      ),
    ],
  ),
  GoRoute(
    path: "/$exerciseRoute",
    builder: (context, state) {
      return ExercisePage();
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
