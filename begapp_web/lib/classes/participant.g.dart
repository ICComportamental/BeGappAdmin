// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      name: json['name'] as String,
      age: MyConverter.stringToInt(json['age'] as String),
      cours: json['cours'] as String,
      gender: json['gender'] as String,
      educationLevel: json['educationLevel'] as String,
      occupation: json['occupation'] as String,
    )
      ..id = MyConverter.stringToInt(json['id'] as String)
      ..experiment = json['experiment'] as String
      ..device = json['device'] as String;

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': MyConverter.stringFromInt(instance.id),
      'name': instance.name,
      'age': MyConverter.stringFromInt(instance.age),
      'gender': instance.gender,
      'cours': instance.cours,
      'educationLevel': instance.educationLevel,
      'occupation': instance.occupation,
      'experiment': instance.experiment,
      'device': instance.device,
    };
