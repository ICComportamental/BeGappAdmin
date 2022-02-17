// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestUserAdmin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserRequest _$AdminUserRequestFromJson(Map<String, dynamic> json) =>
    AdminUserRequest(
      MyConverter.stringToInt(json['id'] as String),
      json['name'] as String,
      json['email'] as String,
      json['intention'] as String,
      MyConverter.stringToBool(json['approved'] as String),
      json['lang'] as String,
    );

Map<String, dynamic> _$AdminUserRequestToJson(AdminUserRequest instance) =>
    <String, dynamic>{
      'id': MyConverter.stringFromInt(instance.id),
      'name': instance.name,
      'email': instance.email,
      'intention': instance.intention,
      'lang': instance.lang,
      'approved': MyConverter.stringFromBool(instance.approved),
    };
