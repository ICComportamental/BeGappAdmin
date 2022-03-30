import 'package:begapp_web/classes/myconverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PG_variables.g.dart';

@JsonSerializable()
class PublicGoodsVariables {
  late String adminId; //id do admin criador do experimento
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool publicConfig; // se essa configuração de experimento é publica
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool publicData; //se os resultados do experimento são publicos
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool
      onlyContribution; //se o exprimento possui apenas a fase de contribuição
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int id;
  late String key;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool active;

  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int maxTokens; //maximo de fichas para investir
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int time; //tempo do round
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int factor; //fator de multiplicação do dinheiro
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int maxTrys;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int realPlayers; //numero de jogadores reais alem do usuario
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int notRealPlayers; //numero de jogadores simulados alem do usuario
  late String name; //nome da configuração do jogo
  late String descri; //descrição experimento
  late DateTime start;
  late DateTime end;

  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  late bool showRounds;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int timeDistribution;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int timeElection;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int contributionsVariation;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int distributionVariation;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int unfairDistribution;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int stable;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int limitVotes;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int waitingRounds;

  @JsonKey(fromJson: MyConverter.ruleToInt, toJson: MyConverter.ruleFromInt)
  late int electionRule;

  PublicGoodsVariables(
      this.adminId,
      this.publicConfig,
      this.publicData,
      this.key,
      this.maxTokens,
      this.time,
      this.factor,
      this.maxTrys,
      this.realPlayers,
      this.notRealPlayers,
      this.name,
      this.descri,
      this.start,
      this.end,
      this.showRounds,
      this.timeDistribution,
      this.timeElection,
      this.contributionsVariation,
      this.distributionVariation,
      this.unfairDistribution,
      this.stable,
      this.limitVotes,
      this.waitingRounds,
      this.electionRule,
      this.active);

  factory PublicGoodsVariables.fromJson(Map<String, dynamic> json) =>
      _$PublicGoodsVariablesFromJson(json);
  Map<String, dynamic> toJson() => _$PublicGoodsVariablesToJson(this);

  // static int MyConverter.stringToInt(String number) =>
  //     number == null ? null : int.parse(number);
  // static String MyConverter.stringFromInt(int number) => number?.toString();

  // static int MyConverter.ruleToInt(String rule) => rule == null ? null : getRule(rule);
  // static String _ruleFromInt(int rule) => rule?.toString();

  // static bool MyConverter.stringToBool(String b) => b == null ? null : parseBool(b);
  // static String MyConverter.stringFromBool(bool b) => b?.toString();

  // static bool parseBool(String b) {
  //   return b.toLowerCase() == '1';
  // }

  // static int getRule(String rule) {
  //   switch (rule) {
  //     case "intermittent election disabled":
  //       return 1;
  //       break;
  //     case "intermittent election enabled":
  //       return 2;
  //       break;
  //     case "recurring election disabled":
  //       return 3;
  //       break;
  //     case "recurring election enabled":
  //       return 4;
  //       break;
  //     default:
  //       return 0;
  //   }
  // }

  maxWalletValue() {
    double max;
    int maxRib;
    double maxEarning;
    maxRib = (notRealPlayers + 1) * maxTokens * factor;
    maxEarning = maxRib / (notRealPlayers + 1);
    max = maxEarning * maxTrys;

    return max;
  }
}
