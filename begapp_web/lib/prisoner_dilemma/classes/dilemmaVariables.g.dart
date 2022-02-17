// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dilemmaVariables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DilemmaVariables _$DilemmaVariablesFromJson(Map<String, dynamic> json) =>
    DilemmaVariables(
      json['adminId'] as String,
      MyConverter.stringToBool(json['publicConfig'] as String),
      MyConverter.stringToBool(json['publicData'] as String),
      json['key'] as String,
      json['algorithm'] as String,
      json['secondAlgorithm'] as String,
      json['dependentVariable'] as String,
      json['independentVariable'] as String,
      json['gameName'] as String,
      MyConverter.stringToInt(json['bothCooperate'] as String),
      MyConverter.stringToInt(json['bothDefect'] as String),
      MyConverter.stringToInt(json['cooperateLoses'] as String),
      MyConverter.stringToInt(json['defectWin'] as String),
      MyConverter.stringToInt(json['roundsNumber'] as String),
      MyConverter.stringToInt(json['maxTime'] as String),
      MyConverter.stringToInt(json['stable'] as String),
      MyConverter.stringToBool(json['showRounds'] as String),
      MyConverter.stringToBool(json['showClock'] as String),
      MyConverter.stringToBool(json['showYourPoints'] as String),
      MyConverter.stringToBool(json['showOtherPoints'] as String),
      MyConverter.stringToBool(json['yourPointsRand'] as String),
      MyConverter.stringToBool(json['otherPointsRand'] as String),
      DateTime.parse(json['start'] as String),
      DateTime.parse(json['end'] as String),
      MyConverter.stringToBool(json['active'] as String),
      json['formLink'] as String,
    )..id = MyConverter.stringToInt(json['id'] as String);

Map<String, dynamic> _$DilemmaVariablesToJson(DilemmaVariables instance) =>
    <String, dynamic>{
      'adminId': instance.adminId,
      'publicConfig': MyConverter.stringFromBool(instance.publicConfig),
      'publicData': MyConverter.stringFromBool(instance.publicData),
      'id': MyConverter.stringFromInt(instance.id),
      'key': instance.key,
      'algorithm': instance.algorithm,
      'secondAlgorithm': instance.secondAlgorithm,
      'gameName': instance.gameName,
      'dependentVariable': instance.dependentVariable,
      'independentVariable': instance.independentVariable,
      'formLink': instance.formLink,
      'bothCooperate': MyConverter.stringFromInt(instance.bothCooperate),
      'bothDefect': MyConverter.stringFromInt(instance.bothDefect),
      'cooperateLoses': MyConverter.stringFromInt(instance.cooperateLoses),
      'defectWin': MyConverter.stringFromInt(instance.defectWin),
      'roundsNumber': MyConverter.stringFromInt(instance.roundsNumber),
      'maxTime': MyConverter.stringFromInt(instance.maxTime),
      'stable': MyConverter.stringFromInt(instance.stable),
      'showRounds': MyConverter.stringFromBool(instance.showRounds),
      'showClock': MyConverter.stringFromBool(instance.showClock),
      'showYourPoints': MyConverter.stringFromBool(instance.showYourPoints),
      'showOtherPoints': MyConverter.stringFromBool(instance.showOtherPoints),
      'yourPointsRand': MyConverter.stringFromBool(instance.yourPointsRand),
      'otherPointsRand': MyConverter.stringFromBool(instance.otherPointsRand),
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'active': MyConverter.stringFromBool(instance.active),
    };
