import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'adminUser.g.dart';

@JsonSerializable()
class AdminUser {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  int id;
  String name;
  String username;
  String password;
  String email;
  String userType;
  String code;

  AdminUser(this.id, this.name, this.username, this.password, this.email,
      this.userType, this.code);

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUserToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();
}
