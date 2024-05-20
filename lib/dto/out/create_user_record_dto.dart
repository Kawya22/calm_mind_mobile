import 'package:json_annotation/json_annotation.dart';

part 'create_user_record_dto.g.dart';

@JsonSerializable()
class CreateUserRecordDto {
  String id;
  final String email;
  final String emotion;
  final int rate;
  final DateTime createdOn = DateTime.now();

  CreateUserRecordDto({
    required this.email,
    required this.emotion,
    required this.rate,
    this.id = "",
  });

  factory CreateUserRecordDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);
}
