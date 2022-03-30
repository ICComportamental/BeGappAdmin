import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'participant.g.dart';

@JsonSerializable()
class Participant {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int id;
  late String name = "";
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int age;
  late String gender = "";
  late String cours = "";
  late String educationLevel = "";
  late String occupation = "";
  late String experiment = "";
  late String device = "";

  Participant(
      {required this.name,
      required this.age,
      required this.cours,
      required this.gender,
      required this.educationLevel,
      required this.occupation});
  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();
}
