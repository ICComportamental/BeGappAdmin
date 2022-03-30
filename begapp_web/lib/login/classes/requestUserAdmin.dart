import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'requestUserAdmin.g.dart';

@JsonSerializable()
class AdminUserRequest {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  int id;
  String name;
  String email;
  String intention;
  String lang;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  bool approved;

  AdminUserRequest(
      this.id, this.name, this.email, this.intention, this.approved, this.lang);

  factory AdminUserRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUserRequestToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static bool MyConverter.stringToBool(String b) => b == null ? null : parseBool(b);
  // static String MyConverter.stringFromBool(bool b) => b?.toString();

  // static bool parseBool(String b) {
  //   return b.toLowerCase() == '1';
  // }
}
