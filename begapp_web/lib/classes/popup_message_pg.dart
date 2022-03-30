import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'popup_message_pg.g.dart';

@JsonSerializable()
class PopUpMessagePublicGoods {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int id;
  final String message;
  final String experiment;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int round;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int level;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool criterion;

  PopUpMessagePublicGoods(this.id, this.message, this.experiment, this.round,
      this.level, this.criterion);

  factory PopUpMessagePublicGoods.fromJson(Map<String, dynamic> json) =>
      _$PopUpMessagePublicGoodsFromJson(json);
  Map<String, dynamic> toJson() => _$PopUpMessagePublicGoodsToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static bool stringToBool(String b) => b == null ? null : parseBool(b);
  // static String MyConverter.stringFromBool(bool b) => b?.toString();

  // static bool parseBool(String b) {
  //   return b.toLowerCase() == '1';
  // }
}
