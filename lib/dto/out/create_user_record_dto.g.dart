// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_record_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserRecordDto _$CreateUserDtoFromJson(Map<String, dynamic> json) =>
    CreateUserRecordDto(
      id: json['id'] as String? ?? "",
      email: json['email'] as String,
      emotion: json['emotion'] as String,
      rate: json['rate'] as int,
    );

Map<String, dynamic> _$CreateUserDtoToJson(CreateUserRecordDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'emotion': instance.emotion,
      'rate': instance.rate,
      'createdOn': instance.createdOn,
    };
