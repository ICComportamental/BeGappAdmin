// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgparticipant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgParticipant _$PgParticipantFromJson(Map<String, dynamic> json) =>
    PgParticipant(
      MyConverter.stringToInt(json['userId'] as String),
      MyConverter.stringToInt(json['age'] as String),
      json['gender'] as String,
      json['occupation'] as String,
      json['educationLevel'] as String,
      json['cours'] as String,
      json['experiment'] as String,
      MyConverter.stringToDuration(json['total'] as String),
      MyConverter.stringToDuration(json['tutorialMain'] as String),
      MyConverter.stringToDuration(json['tutorialDistribution'] as String),
      MyConverter.stringToDuration(json['tutorialElection'] as String),
      MyConverter.stringToInt(json['sawMainTutorial'] as String),
      MyConverter.stringToInt(json['sawDistributionTutorial'] as String),
      MyConverter.stringToInt(json['sawElectionTutorial'] as String),
    );

Map<String, dynamic> _$PgParticipantToJson(PgParticipant instance) =>
    <String, dynamic>{
      'userId': MyConverter.stringFromInt(instance.userId),
      'age': MyConverter.stringFromInt(instance.age),
      'gender': instance.gender,
      'occupation': instance.occupation,
      'educationLevel': instance.educationLevel,
      'cours': instance.cours,
      'experiment': instance.experiment,
      'total': MyConverter.stringFromDuration(instance.total),
      'tutorialMain': MyConverter.stringFromDuration(instance.tutorialMain),
      'tutorialDistribution':
          MyConverter.stringFromDuration(instance.tutorialDistribution),
      'tutorialElection':
          MyConverter.stringFromDuration(instance.tutorialElection),
      'sawMainTutorial': MyConverter.stringFromInt(instance.sawMainTutorial),
      'sawDistributionTutorial':
          MyConverter.stringFromInt(instance.sawDistributionTutorial),
      'sawElectionTutorial':
          MyConverter.stringFromInt(instance.sawElectionTutorial),
    };
