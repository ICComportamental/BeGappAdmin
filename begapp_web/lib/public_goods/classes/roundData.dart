import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'roundData.g.dart';

@JsonSerializable()
class RoundData {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int userId;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int round;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int investment;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int positionToken;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int earning;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int rib;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int wallet;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int distribution;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int suspended;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int electionCount;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int votes;
  @JsonKey(
      fromJson: MyConverter.stringToDuration,
      toJson: MyConverter.stringFromDuration)
  final Duration dragToken;
  @JsonKey(
      fromJson: MyConverter.stringToDuration,
      toJson: MyConverter.stringFromDuration)
  final Duration distributionTime;
  @JsonKey(
      fromJson: MyConverter.stringToDuration,
      toJson: MyConverter.stringFromDuration)
  final Duration electionTime;

  RoundData(
      this.userId,
      this.round,
      this.investment,
      this.positionToken,
      this.earning,
      this.rib,
      this.wallet,
      this.distribution,
      this.suspended,
      this.electionCount,
      this.votes,
      this.dragToken,
      this.distributionTime,
      this.electionTime);

  factory RoundData.fromJson(Map<String, dynamic> json) =>
      _$RoundDataFromJson(json);
  Map<String, dynamic> toJson() => _$RoundDataToJson(this);

  // static int MyConverter.stringToInt(String number) => number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static Duration MyConverter.stringToDuration(String s) {
  //   if(s == null) return null;
  //   int hours = 0;
  //   int minutes = 0;
  //   int micros;
  //   List<String> parts = s.split(':');
  //   if (parts.length > 2) {
  //     hours = int.parse(parts[parts.length - 3]);
  //   }
  //   if (parts.length > 1) {
  //     minutes = int.parse(parts[parts.length - 2]);
  //   }
  //   micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  //   return Duration(hours: hours, minutes: minutes, microseconds: micros);
  // }

  // static String MyConverter.stringFromDuration(Duration d){
  //   return d.toString();
  // }
}
