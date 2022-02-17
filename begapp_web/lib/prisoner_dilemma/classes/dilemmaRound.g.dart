// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dilemmaRound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DilemmaRound _$DilemmaRoundFromJson(Map<String, dynamic> json) => DilemmaRound(
      MyConverter.stringToInt(json['userId'] as String),
      MyConverter.stringToInt(json['round'] as String),
      MyConverter.stringToInt(json['computer'] as String),
      MyConverter.stringToInt(json['userChoice'] as String),
      MyConverter.stringToInt(json['otherPoints'] as String),
      MyConverter.stringToInt(json['userPoints'] as String),
      MyConverter.stringToInt(json['lostRound'] as String),
      MyConverter.stringToInt(json['sawOtherPoints'] as String),
      MyConverter.stringToInt(json['sawYourPoints'] as String),
      MyConverter.stringToDuration(json['dragCard'] as String),
    );

Map<String, dynamic> _$DilemmaRoundToJson(DilemmaRound instance) =>
    <String, dynamic>{
      'userId': MyConverter.stringFromInt(instance.userId),
      'round': MyConverter.stringFromInt(instance.round),
      'computer': MyConverter.stringFromInt(instance.computer),
      'userChoice': MyConverter.stringFromInt(instance.userChoice),
      'otherPoints': MyConverter.stringFromInt(instance.otherPoints),
      'userPoints': MyConverter.stringFromInt(instance.userPoints),
      'lostRound': MyConverter.stringFromInt(instance.lostRound),
      'sawOtherPoints': MyConverter.stringFromInt(instance.sawOtherPoints),
      'sawYourPoints': MyConverter.stringFromInt(instance.sawYourPoints),
      'dragCard': MyConverter.stringFromDuration(instance.dragCard),
    };
