import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/localdata.dart';
import 'package:school_english/pages/error_page/error_page.dart';
import 'package:school_english/pages/exercise/exercise_page.dart';
import 'package:school_english/pages/login/login_page.dart';
import 'package:school_english/pages/modules/module_create_page/module_create_page.dart';
import 'package:school_english/pages/modules/module_edit_page/module_edit_page.dart';
import 'package:school_english/pages/modules/modules_page/modules_page.dart';
import 'package:school_english/pages/register/register_page.dart';
import 'package:school_english/pages/task_part/taskpart_create_page/taskpart_create_page.dart';
import 'package:school_english/pages/task_part/taskpart_edit_page/taskpart_edit_page.dart';
import 'package:school_english/pages/tasks/task_create_page/task_create_page.dart';
import 'package:school_english/pages/teacher_code/teacher_code_page.dart';
import 'package:school_english/pages/profile/profile_page.dart';
import 'package:school_english/pages/welcome/welcome_page.dart';

import 'pages/tasks/task_edit_page/task_edit_page.dart';

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
    path: "/$moduleCreateRoute",
    builder: (context, state) {
      return ModuleCreatePage(
        parentId: state.queryParams["parentId"],
      );
    },
  ),
  GoRoute(
    path: "/$moduleEditRoute",
    builder: (context, state) {
      var moduleId = state.queryParams["moduleId"];
      if (Validator.isNullOrEmpty(moduleId)) {
        return const ErrorPage();
      } else {
        return ModuleEditPage(
          moduleId: moduleId!,
        );
      }
    },
  ),
  GoRoute(
    path: "/$taskCreateRoute",
    builder: (context, state) {
      var moduleId = state.queryParams["moduleId"];
      if (Validator.isNullOrEmpty(moduleId)) {
        return const ErrorPage();
      } else {
        return TaskCreatePage(
          moduleId: moduleId!,
        );
      }
    },
  ),
  GoRoute(
    path: "/$taskEditRoute",
    builder: (context, state) {
      var taskId = state.queryParams["taskId"];
      if (Validator.isNullOrEmpty(taskId)) {
        return const ErrorPage();
      } else {
        return TaskEditPage(
          taskId: taskId!,
        );
      }
    },
  ),
  GoRoute(
    path: "/$taskPartCreateRoute",
    builder: (context, state) {
      var taskId = state.queryParams["taskId"];
      if (Validator.isNullOrEmpty(taskId)) {
        return const ErrorPage();
      } else {
        return TaskPartCreatePage(
          taskId: taskId!,
        );
      }
    },
  ),
  GoRoute(
    path: "/$taskPartEditRoute",
    builder: (context, state) {
      var taskPartId = state.queryParams["taskPartId"];
      if (Validator.isNullOrEmpty(taskPartId)) {
        return const ErrorPage();
      } else {
        return TaskPartEditPage(
          taskPartId: taskPartId!,
        );
      }
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
