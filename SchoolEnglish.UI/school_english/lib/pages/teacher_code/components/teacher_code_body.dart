import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/pages/components/base_page_body.dart';

class TeacherCodeBody extends StatelessWidget {
  const TeacherCodeBody(
      {super.key,
      required this.userIsTeacher,
      this.formKey,
      this.teacherCode,
      this.codeController});

  final GlobalKey<FormState>? formKey;
  final bool userIsTeacher;
  final String? teacherCode;
  final TextEditingController? codeController;

  @override
  Widget build(BuildContext context) {
    return BasePageBody(
      header: teacherCodeHeader,
      description:
          userIsTeacher ? teacherCodeDescription : enterTeacherCodeDescription,
      child: userIsTeacher
          ? Align(
              alignment: Alignment.center,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(singleSpace),
                  child: Text(
                    teacherCode!,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            )
          : Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: codeController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.pin),
                        border: OutlineInputBorder(),
                        hintText: "Код"),
                    keyboardType: TextInputType.number,
                    validator: (code) {
                      if (Validator.isNullOrEmpty(code)) {
                        return "Введите код учителя!";
                      } else if (code!.length < 4) {
                        return "Код состоит минимум из 4 цифр!";
                      } else if (!Validator.validateTeacherCode(code)) {
                        return "Некорректный код!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
