import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/models/user/user.dart';
import 'package:school_english/pages/components/base_item.dart';

class StudentsBody extends StatefulWidget {
  const StudentsBody({super.key, required this.students, this.onStudentClick});

  final List<User> students;
  final void Function(String studentId)? onStudentClick;

  @override
  State<StudentsBody> createState() => _StudentsBodyState();
}

class _StudentsBodyState extends State<StudentsBody> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Поиск ученика(цы)"),
              onChanged: (String? value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(
            height: singleSpace,
          ),
          const Divider(),
          ...buildStudentItems(),
        ],
      ),
    );
  }

  List<Widget> buildStudentItems() {
    List<Widget> studentItems = [];
    for (var student in widget.students) {
      if ("${student.surname} ${student.name} ${student.email}"
          .toLowerCase()
          .contains(searchController.text.toLowerCase())) {
        studentItems.add(Padding(
          padding: const EdgeInsets.all(singleSpace / 2),
          child: BaseItem(
            itemName: "ученик",
            title: "${student.surname} ${student.name}",
            onClick: () {
              if (widget.onStudentClick != null) {
                widget.onStudentClick!(student.id);
              }
            },
          ),
        ));
      }
    }
    return studentItems;
  }
}
