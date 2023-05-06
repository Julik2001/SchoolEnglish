import 'package:flutter/material.dart';
import 'package:school_english/constants.dart';

class ModuleEditBody extends StatefulWidget {
  const ModuleEditBody(
      {super.key,
      required this.formKey,
      this.nameController,
      this.numberController});

  final GlobalKey<FormState> formKey;
  final TextEditingController? nameController;
  final TextEditingController? numberController;

  @override
  State<ModuleEditBody> createState() => _ModuleEditBodyState();
}

class _ModuleEditBodyState extends State<ModuleEditBody> {
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
              moduleEditHeader,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text(
              moduleEditDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: widget.nameController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.abc),
                          border: OutlineInputBorder(),
                          hintText: "Название"),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: singleSpace,
                    ),
                    TextFormField(
                      controller: widget.numberController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.numbers),
                          border: OutlineInputBorder(),
                          hintText: "Номер"),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: singleSpace * 2,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
