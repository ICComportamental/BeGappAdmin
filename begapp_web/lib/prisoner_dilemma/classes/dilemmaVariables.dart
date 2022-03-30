import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dilemmaVariables.g.dart';

@JsonSerializable()
class DilemmaVariables {
  late String adminId; //id do admin criador do experimento
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool publicConfig; // se essa configuração de experimento é publica
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool publicData; //se os resultados do experimento são publicos
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int id;
  late String key;

  late String algorithm;
  late String secondAlgorithm;
  late String gameName;
  late String dependentVariable;
  late String independentVariable;
  late String formLink;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int bothCooperate;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int bothDefect;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int cooperateLoses;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int defectWin;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int roundsNumber;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int maxTime;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int stable;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool showRounds;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool showClock;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool showYourPoints;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool showOtherPoints;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool yourPointsRand;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool otherPointsRand;
  late DateTime start;
  late DateTime end;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool active;

  DilemmaVariables(
    this.adminId,
    this.publicConfig,
    this.publicData,
    this.key,
    this.algorithm,
    this.secondAlgorithm,
    this.dependentVariable,
    this.independentVariable,
    this.gameName,
    this.bothCooperate,
    this.bothDefect,
    this.cooperateLoses,
    this.defectWin,
    this.roundsNumber,
    this.maxTime,
    this.stable,
    this.showRounds,
    this.showClock,
    this.showYourPoints,
    this.showOtherPoints,
    this.yourPointsRand,
    this.otherPointsRand,
    this.start,
    this.end,
    this.active,
    this.formLink,
  );

  factory DilemmaVariables.fromJson(Map<String, dynamic> json) =>
      _$DilemmaVariablesFromJson(json);
  Map<String, dynamic> toJson() => _$DilemmaVariablesToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static bool MyConverter.stringToBool(String b) => b == null ? null : parseBool(b);
  // static String MyConverter.stringFromBool(bool b) => b?.toString();

  // static bool parseBool(String b) {
  //   return b.toLowerCase() == '1';
  // }

  // factory DilemmaVaribles.fromJson(Map<String, dynamic> json) =>
  // DilemmaVaribles(
  //   gameName: json['gameName'],
  //   bothCooperate: json['bothCooperate'],
  //   bothDefect: json['bothDefect'],
  //   defectLoses: json['defectLoses'],
  //   defectWin: json['defectWin'],
  //   roundsNumber: json['roundsNumber'],
  //   showRounds: json['showRounds'],
  //   );
}
// class DilemmaVaribles{
//    static String gameName = "default";
//    static int bothCooperate = 5;
//    static int bothDefect = 2;
//    static int defectLoses = 1;
//    static int defectWin = 6;
//    static int roundsNumber = 10;
//    static bool showRounds =false;
// }
// class Usuario {
//   Usuario({this.id, this.nome, this.telefone, this.email});

//   String id;
//   String nome;
//   String telefone;
//   String email;

//   factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
//     id: json["id"],
//     nome: json["nome"],
//     telefone: json["telefone"],
//     email: json["email"]);
// }
