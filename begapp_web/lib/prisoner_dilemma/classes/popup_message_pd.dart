import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'popup_message_pd.g.dart';

@JsonSerializable()
class PopUpMessagePrisonersDilemma {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int id;
  final String message;
  final String experiment;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int round;

  PopUpMessagePrisonersDilemma(
    this.id,
    this.message,
    this.experiment,
    this.round,
  );

  factory PopUpMessagePrisonersDilemma.fromJson(Map<String, dynamic> json) =>
      _$PopUpMessagePrisonersDilemmaFromJson(json);
  Map<String, dynamic> toJson() => _$PopUpMessagePrisonersDilemmaToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static bool _stringToBool(String b) => b == null ? null : parseBool(b);
  // static String _stringFromBool(bool b) => b?.toString();

  // static bool parseBool(String b) {
  //   return b.toLowerCase() == '1';
  // }
}
