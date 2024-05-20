// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserDto _$CreateUserDtoFromJson(Map<String, dynamic> json) =>
    CreateUserDto(
      email: json['email'] as String,
      name: json['name'] as String,
      id: json['id'] as String? ?? "",
    );

Map<String, dynamic> _$CreateUserDtoToJson(CreateUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'createdOn': instance.createdOn,
    };
