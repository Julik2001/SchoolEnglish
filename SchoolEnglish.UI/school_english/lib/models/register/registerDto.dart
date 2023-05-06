import 'package:json_annotation/json_annotation.dart';

part 'registerDto.g.dart';

@JsonSerializable()
class RegisterDto {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String roleId;

  RegisterDto(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.roleId});

  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}
