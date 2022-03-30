import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dilemma_participant.g.dart';

@JsonSerializable()
class DilemmaParticipant {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int userId;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int age;
  final String gender;
  final String occupation;
  final String educationLevel;
  final String cours;
  final String experiment;
  @JsonKey(
      fromJson: MyConverter.stringToDuration,
      toJson: MyConverter.stringFromDuration)
  final Duration total;

  @JsonKey(
      fromJson: MyConverter.stringToDuration,
      toJson: MyConverter.stringFromDuration)
  final Duration tutorial;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int sawTutorial;

  DilemmaParticipant(
      this.userId,
      this.age,
      this.gender,
      this.occupation,
      this.educationLevel,
      this.cours,
      this.experiment,
      this.total,
      this.tutorial,
      this.sawTutorial);

  factory DilemmaParticipant.fromJson(Map<String, dynamic> json) =>
      _$DilemmaParticipantFromJson(json);
  Map<String, dynamic> toJson() => _$DilemmaParticipantToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static Duration MyConverter.stringToDuration(String s) {
  //   if (s == null) return null;
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

  // static String MyConverter.stringFromDuration(Duration d) {
  //   return d.toString();
  // }
}
