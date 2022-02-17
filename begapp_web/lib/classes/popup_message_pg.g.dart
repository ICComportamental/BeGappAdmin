// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popup_message_pg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopUpMessagePublicGoods _$PopUpMessagePublicGoodsFromJson(
        Map<String, dynamic> json) =>
    PopUpMessagePublicGoods(
      MyConverter.stringToInt(json['id'] as String),
      json['message'] as String,
      json['experiment'] as String,
      MyConverter.stringToInt(json['round'] as String),
      MyConverter.stringToInt(json['level'] as String),
      MyConverter.stringToBool(json['criterion'] as String),
    );

Map<String, dynamic> _$PopUpMessagePublicGoodsToJson(
        PopUpMessagePublicGoods instance) =>
    <String, dynamic>{
      'id': MyConverter.stringFromInt(instance.id),
      'message': instance.message,
      'experiment': instance.experiment,
      'round': MyConverter.stringFromInt(instance.round),
      'level': MyConverter.stringFromInt(instance.level),
      'criterion': MyConverter.stringFromBool(instance.criterion),
    };
