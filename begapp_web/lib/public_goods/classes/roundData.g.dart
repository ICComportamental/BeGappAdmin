// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roundData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoundData _$RoundDataFromJson(Map<String, dynamic> json) => RoundData(
      MyConverter.stringToInt(json['userId'] as String),
      MyConverter.stringToInt(json['round'] as String),
      MyConverter.stringToInt(json['investment'] as String),
      MyConverter.stringToInt(json['positionToken'] as String),
      MyConverter.stringToInt(json['earning'] as String),
      MyConverter.stringToInt(json['rib'] as String),
      MyConverter.stringToInt(json['wallet'] as String),
      MyConverter.stringToInt(json['distribution'] as String),
      MyConverter.stringToInt(json['suspended'] as String),
      MyConverter.stringToInt(json['electionCount'] as String),
      MyConverter.stringToInt(json['votes'] as String),
      MyConverter.stringToDuration(json['dragToken'] as String),
      MyConverter.stringToDuration(json['distributionTime'] as String),
      MyConverter.stringToDuration(json['electionTime'] as String),
    );

Map<String, dynamic> _$RoundDataToJson(RoundData instance) => <String, dynamic>{
      'userId': MyConverter.stringFromInt(instance.userId),
      'round': MyConverter.stringFromInt(instance.round),
      'investment': MyConverter.stringFromInt(instance.investment),
      'positionToken': MyConverter.stringFromInt(instance.positionToken),
      'earning': MyConverter.stringFromInt(instance.earning),
      'rib': MyConverter.stringFromInt(instance.rib),
      'wallet': MyConverter.stringFromInt(instance.wallet),
      'distribution': MyConverter.stringFromInt(instance.distribution),
      'suspended': MyConverter.stringFromInt(instance.suspended),
      'electionCount': MyConverter.stringFromInt(instance.electionCount),
      'votes': MyConverter.stringFromInt(instance.votes),
      'dragToken': MyConverter.stringFromDuration(instance.dragToken),
      'distributionTime':
          MyConverter.stringFromDuration(instance.distributionTime),
      'electionTime': MyConverter.stringFromDuration(instance.electionTime),
    };
