// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maxLength.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaxLength _$MaxLengthFromJson(Map<String, dynamic> json) => MaxLength(
      MyConverter.stringToInt(json['character_maximum_length'] as String),
    );

Map<String, dynamic> _$MaxLengthToJson(MaxLength instance) => <String, dynamic>{
      'character_maximum_length':
          MyConverter.stringFromInt(instance.character_maximum_length),
    };
