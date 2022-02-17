// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adminUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUser _$AdminUserFromJson(Map<String, dynamic> json) => AdminUser(
      MyConverter.stringToInt(json['id'] as String),
      json['name'] as String,
      json['username'] as String,
      json['password'] as String,
      json['email'] as String,
      json['userType'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$AdminUserToJson(AdminUser instance) => <String, dynamic>{
      'id': MyConverter.stringFromInt(instance.id),
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'userType': instance.userType,
      'code': instance.code,
    };
