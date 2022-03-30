import 'package:json_annotation/json_annotation.dart';
import 'package:begapp_web/classes/myconverter.dart';
part 'dilemmaRound.g.dart';

@JsonSerializable()
class DilemmaRound {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int userId;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int round;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int computer;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int userChoice;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int otherPoints;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int userPoints;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int lostRound;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int sawOtherPoints;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int sawYourPoints;
  @JsonKey(
      fromJson: MyConverter.stringToDuration,
      toJson: MyConverter.stringFromDuration)
  final Duration dragCard;

  DilemmaRound(
      this.userId,
      this.round,
      this.computer,
      this.userChoice,
      this.otherPoints,
      this.userPoints,
      this.lostRound,
      this.sawOtherPoints,
      this.sawYourPoints,
      this.dragCard);

  factory DilemmaRound.fromJson(Map<String, dynamic> json) =>
      _$DilemmaRoundFromJson(json);
  Map<String, dynamic> toJson() => _$DilemmaRoundToJson(this);
}
