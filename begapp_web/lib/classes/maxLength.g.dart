// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maxLength.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaxLength _$MaxLengthFromJson(Map<String, dynamic> json) => MaxLength(
      MyConverter.stringToInt(json['CHARACTER_MAXIMUM_LENGTH'] as String),
    );

Map<String, dynamic> _$MaxLengthToJson(MaxLength instance) => <String, dynamic>{
      'CHARACTER_MAXIMUM_LENGTH':
          MyConverter.stringFromInt(instance.CHARACTER_MAXIMUM_LENGTH),
    };
