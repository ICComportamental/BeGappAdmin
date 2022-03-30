import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'maxLength.g.dart';

@JsonSerializable()
class MaxLength {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  // ignore: non_constant_identifier_names
  final int CHARACTER_MAXIMUM_LENGTH;

  MaxLength(this.CHARACTER_MAXIMUM_LENGTH);

  factory MaxLength.fromJson(Map<String, dynamic> json) =>
      _$MaxLengthFromJson(json);
  Map<String, dynamic> toJson() => _$MaxLengthToJson(this);
}
