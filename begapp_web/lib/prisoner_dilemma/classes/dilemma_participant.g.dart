// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dilemma_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DilemmaParticipant _$DilemmaParticipantFromJson(Map<String, dynamic> json) =>
    DilemmaParticipant(
      MyConverter.stringToInt(json['userId'] as String),
      MyConverter.stringToInt(json['age'] as String),
      json['gender'] as String,
      json['occupation'] as String,
      json['educationLevel'] as String,
      json['cours'] as String,
      json['experiment'] as String,
      MyConverter.stringToDuration(json['total'] as String),
      MyConverter.stringToDuration(json['tutorial'] as String),
      MyConverter.stringToInt(json['sawTutorial'] as String),
    );

Map<String, dynamic> _$DilemmaParticipantToJson(DilemmaParticipant instance) =>
    <String, dynamic>{
      'userId': MyConverter.stringFromInt(instance.userId),
      'age': MyConverter.stringFromInt(instance.age),
      'gender': instance.gender,
      'occupation': instance.occupation,
      'educationLevel': instance.educationLevel,
      'cours': instance.cours,
      'experiment': instance.experiment,
      'total': MyConverter.stringFromDuration(instance.total),
      'tutorial': MyConverter.stringFromDuration(instance.tutorial),
      'sawTutorial': MyConverter.stringFromInt(instance.sawTutorial),
    };
