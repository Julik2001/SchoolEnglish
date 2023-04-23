import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/validator.dart';

class TeacherCodeBody extends StatelessWidget {
  const TeacherCodeBody(
      {super.key, required this.isTeacherUser, this.teacherCode, this.formKey});

  final GlobalKey<FormState>? formKey;
  final bool isTeacherUser;
  final String? teacherCode;

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
              teacherCodeHeader,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text(
              isTeacherUser
                  ? teacherCodeDescription
                  : enterTeacherCodeDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            isTeacherUser
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
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.pin),
                              border: OutlineInputBorder(),
                              hintText: "Код"),
                          keyboardType: TextInputType.number,
                          validator: (code) {
                            if (Validator.isNullOrEmpty(code)) {
                              return "Введите код учителя!";
                            } else if (!Validator.validateTeacherCode(code!)) {
                              return "Некорректный код!";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
            const SizedBox(
              height: singleSpace * 2,
            ),
          ],
        ),
      ),
    );
  }
}
