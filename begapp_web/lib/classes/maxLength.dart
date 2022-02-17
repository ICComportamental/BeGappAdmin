import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'maxLength.g.dart';

@JsonSerializable(nullable: false)
class MaxLength {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  // ignore: non_constant_identifier_names
  final int character_maximum_length;

  MaxLength(this.character_maximum_length);

  factory MaxLength.fromJson(Map<String, dynamic> json) =>
      _$MaxLengthFromJson(json);
  Map<String, dynamic> toJson() => _$MaxLengthToJson(this);
}
