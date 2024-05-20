import 'package:json_annotation/json_annotation.dart';

part 'create_user_dto.g.dart';

@JsonSerializable()
class CreateUserDto {
  String id;
  final String email;
  final String name;
  final DateTime createdOn = DateTime.now();

  CreateUserDto({
    required this.email,
    required this.name,
    this.id = "",
  });

  factory CreateUserDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);
}
