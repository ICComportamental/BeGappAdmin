// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PG_variables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicGoodsVariables _$PublicGoodsVariablesFromJson(
        Map<String, dynamic> json) =>
    PublicGoodsVariables(
      json['adminId'] as String,
      MyConverter.stringToBool(json['publicConfig'] as String),
      MyConverter.stringToBool(json['publicData'] as String),
      json['key'] as String,
      MyConverter.stringToInt(json['maxTokens'] as String),
      MyConverter.stringToInt(json['time'] as String),
      MyConverter.stringToInt(json['factor'] as String),
      MyConverter.stringToInt(json['maxTrys'] as String),
      MyConverter.stringToInt(json['realPlayers'] as String),
      MyConverter.stringToInt(json['notRealPlayers'] as String),
      json['name'] as String,
      json['descri'] as String,
      DateTime.parse(json['start'] as String),
      DateTime.parse(json['end'] as String),
      MyConverter.stringToBool(json['showRounds'] as String),
      MyConverter.stringToInt(json['timeDistribution'] as String),
      MyConverter.stringToInt(json['timeElection'] as String),
      MyConverter.stringToInt(json['contributionsVariation'] as String),
      MyConverter.stringToInt(json['distributionVariation'] as String),
      MyConverter.stringToInt(json['unfairDistribution'] as String),
      MyConverter.stringToInt(json['stable'] as String),
      MyConverter.stringToInt(json['limitVotes'] as String),
      MyConverter.stringToInt(json['waitingRounds'] as String),
      MyConverter.ruleToInt(json['electionRule'] as String),
      MyConverter.stringToBool(json['active'] as String),
    )
      ..onlyContribution =
          MyConverter.stringToBool(json['onlyContribution'] as String)
      ..id = MyConverter.stringToInt(json['id'] as String);

Map<String, dynamic> _$PublicGoodsVariablesToJson(
        PublicGoodsVariables instance) =>
    <String, dynamic>{
      'adminId': instance.adminId,
      'publicConfig': MyConverter.stringFromBool(instance.publicConfig),
      'publicData': MyConverter.stringFromBool(instance.publicData),
      'onlyContribution': MyConverter.stringFromBool(instance.onlyContribution),
      'id': MyConverter.stringFromInt(instance.id),
      'key': instance.key,
      'active': MyConverter.stringFromBool(instance.active),
      'maxTokens': MyConverter.stringFromInt(instance.maxTokens),
      'time': MyConverter.stringFromInt(instance.time),
      'factor': MyConverter.stringFromInt(instance.factor),
      'maxTrys': MyConverter.stringFromInt(instance.maxTrys),
      'realPlayers': MyConverter.stringFromInt(instance.realPlayers),
      'notRealPlayers': MyConverter.stringFromInt(instance.notRealPlayers),
      'name': instance.name,
      'descri': instance.descri,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'showRounds': MyConverter.stringFromBool(instance.showRounds),
      'timeDistribution': MyConverter.stringFromInt(instance.timeDistribution),
      'timeElection': MyConverter.stringFromInt(instance.timeElection),
      'contributionsVariation':
          MyConverter.stringFromInt(instance.contributionsVariation),
      'distributionVariation':
          MyConverter.stringFromInt(instance.distributionVariation),
      'unfairDistribution':
          MyConverter.stringFromInt(instance.unfairDistribution),
      'stable': MyConverter.stringFromInt(instance.stable),
      'limitVotes': MyConverter.stringFromInt(instance.limitVotes),
      'waitingRounds': MyConverter.stringFromInt(instance.waitingRounds),
      'electionRule': MyConverter.ruleFromInt(instance.electionRule),
    };
