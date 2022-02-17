// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popup_message_pd.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopUpMessagePrisonersDilemma _$PopUpMessagePrisonersDilemmaFromJson(
        Map<String, dynamic> json) =>
    PopUpMessagePrisonersDilemma(
      MyConverter.stringToInt(json['id'] as String),
      json['message'] as String,
      json['experiment'] as String,
      MyConverter.stringToInt(json['round'] as String),
    );

Map<String, dynamic> _$PopUpMessagePrisonersDilemmaToJson(
        PopUpMessagePrisonersDilemma instance) =>
    <String, dynamic>{
      'id': MyConverter.stringFromInt(instance.id),
      'message': instance.message,
      'experiment': instance.experiment,
      'round': MyConverter.stringFromInt(instance.round),
    };
