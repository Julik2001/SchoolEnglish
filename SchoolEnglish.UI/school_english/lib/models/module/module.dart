import 'package:json_annotation/json_annotation.dart';

part 'module.g.dart';

@JsonSerializable()
class Module {
  final String id;
  final String number;
  final String name;
  final String? parentId;

  const Module(
      {required this.id,
      required this.name,
      required this.number,
      this.parentId});

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
