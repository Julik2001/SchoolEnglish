import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String teacherCode;

  const User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.teacherCode});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
