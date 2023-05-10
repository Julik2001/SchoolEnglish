import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:school_english/api.dart';
import 'package:school_english/constants.dart';
import 'package:school_english/helpers/message_builder.dart';
import 'package:school_english/helpers/validator.dart';
import 'package:school_english/models/taskpart_content_type/content_type.dart';

class TaskPartContentForm extends StatefulWidget {
  const TaskPartContentForm(
      {super.key,
      required this.types,
      this.formKey,
      this.textController,
      this.textToReadController,
      this.answerVariantsController,
      this.onTypeChanged,
      this.onImagePicked,
      this.onAudioPicked,
      this.typeId,
      this.imagePath,
      this.audioPath});

  final List<TaskPartContentType> types;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? textController;
  final TextEditingController? textToReadController;
  final TextEditingController? answerVariantsController;
  final void Function(String typeId)? onTypeChanged;
  final void Function(File imageFile)? onImagePicked;
  final void Function(File audioFile)? onAudioPicked;
  final String? typeId;
  final String? imagePath;
  final String? audioPath;

  @override
  State<TaskPartContentForm> createState() => _TaskPartContentFormState();
}

class _TaskPartContentFormState extends State<TaskPartContentForm> {
  TaskPartContentType? currentType;
  bool typeHasTextToRead = false;
  bool typeHasAnswerVariants = false;
  bool typeHasImage = false;
  bool typeHasAudio = false;
  String imagePickerLabel = "Изображение не выбрано";
  String audioPickerLabel = "Аудиозапись не выбрана";

  void getData() async {
    if (currentType == null) return;
    typeHasTextToRead = await Api.checkTypeHasTextToRead(currentType!.id);
    typeHasAnswerVariants =
        await Api.checkTypeHasAnswerVariants(currentType!.id);
    typeHasImage = await Api.checkTypeHasImage(currentType!.id);
    typeHasAudio = await Api.checkTypeHasAudio(currentType!.id);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!Validator.isNullOrEmpty(widget.typeId)) {
      currentType =
          widget.types.firstWhere((element) => element.id == widget.typeId);
      getData();
    }
    if (!Validator.isNullOrEmpty(widget.imagePath)) {
      imagePickerLabel = widget.imagePath!;
    }
    if (!Validator.isNullOrEmpty(widget.audioPath)) {
      audioPickerLabel = widget.audioPath!;
    }
  }

  void chooseImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null || result.files.isEmpty) {
      showFilePickerError();
    }

    File file = File(result!.files.first.path!);
    setState(() {
      imagePickerLabel = basename(file.path);
    });
    if (widget.onImagePicked != null) {
      widget.onImagePicked!(file);
    }
  }

  void chooseAudio() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null || result.files.isEmpty) {
      showFilePickerError();
    }

    File file = File(result!.files.first.path!);
    setState(() {
      audioPickerLabel = basename(file.path);
    });
    if (widget.onAudioPicked != null) {
      widget.onAudioPicked!(file);
    }
  }

  void showFilePickerError() =>
      MessageBuilder.showError(context as BuildContext, "Файл не выбран!");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          DropdownButtonFormField<TaskPartContentType>(
            value: currentType,
            isExpanded: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            hint: const Text("Тип части задания"),
            items: widget.types
                .map<DropdownMenuItem<TaskPartContentType>>((type) =>
                    DropdownMenuItem(value: type, child: Text(type.name)))
                .toList(),
            onChanged: (value) {
              currentType = value;
              if (widget.onTypeChanged != null && value != null) {
                widget.onTypeChanged!(value.id);
              }
              getData();
            },
            validator: (value) {
              if (value == null) {
                return "Выберите тип части задания!";
              }
              return null;
            },
          ),
          const SizedBox(
            height: singleSpace,
          ),
          TextFormField(
            controller: widget.textController,
            maxLines: 2,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.abc),
                border: OutlineInputBorder(),
                hintText: "Текст части задания"),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: singleSpace,
          ),
          if (typeHasTextToRead)
            TextFormField(
              controller: widget.textToReadController,
              maxLines: 10,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                  hintText: "Текст для прочтения"),
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите текст для прочтения!";
                }
                return null;
              },
            ),
          if (typeHasTextToRead)
            const SizedBox(
              height: singleSpace,
            ),
          if (typeHasAnswerVariants)
            TextFormField(
              controller: widget.answerVariantsController,
              maxLines: 2,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                  hintText: "Варианты ответа (через точку с запятой)"),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (Validator.isNullOrEmpty(value)) {
                  return "Введите варианты ответа!";
                }
                return null;
              },
            ),
          if (typeHasAnswerVariants)
            const SizedBox(
              height: singleSpace,
            ),
          if (typeHasImage)
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => chooseImage(),
                    child: const Text("Выбрать")),
                const SizedBox(
                  width: singleSpace,
                ),
                Text(imagePickerLabel),
              ],
            ),
          if (typeHasImage)
            const SizedBox(
              height: singleSpace,
            ),
          if (typeHasAudio)
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => chooseAudio(),
                    child: const Text("Выбрать")),
                const SizedBox(
                  width: singleSpace,
                ),
                Text(audioPickerLabel),
              ],
            ),
          const SizedBox(
            height: singleSpace * 2,
          ),
        ],
      ),
    );
  }
}
