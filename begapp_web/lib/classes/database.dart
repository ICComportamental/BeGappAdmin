import 'dart:convert';

import 'package:begapp_web/classes/maxLength.dart';
import 'package:begapp_web/classes/popup_message_pg.dart';
import 'package:begapp_web/login/classes/adminUser.dart';
import 'package:begapp_web/login/classes/requestUserAdmin.dart';
import 'package:begapp_web/main.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/classes/popup_message_pd.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class Database {
  static getEmailBody(String message, String btnText) async {
    String url = "https://v1.begapp.com.br/EmailBody.php";

    var res = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "message": message,
      "btnText": btnText,
    });
    String emailBody = res.body;
    return emailBody;
  }

  // static sendEmail(String email, String subject, String message) async {
  //   // String url = "http://localhost/sendEmail/index.php";
  //   String url = "https://v1.begapp.com.br/sendEmail/index.php";
  //   String from = "begapp@ccompjr.com.br";
  //   String to = email;
  //   String password = "GFVr%9QqduT}";

  //   String body = message;

  //   var res = await http.post(Uri.parse(url), headers: {
  //     "Accept": "application/json"
  //   }, body: {
  //     "emailFrom": from,
  //     "emailPassword": password,
  //     "emailTo": to,
  //     "emailSubject": subject,
  //     "emailBody": body,
  //   });
  //   // //print(res.body);
  //   return res.body;
  // }

  static sendgrid(String email, String subject, String message) async {
    // String url = "http://localhost/sendEmail/index.php";
    String url = "https://v1.begapp.com.br/sendgrid/index.php";
    String to = email;

    String body = message;

    var res = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "emailTo": to,
      "emailSubject": subject,
      "emailBody": body,
    });
    // //print(res.body);
    return res.body;
  }

  static validateLogin(String username, String password) async {
    var bytes = utf8.encode(password); //transforma a senha em hash

    var digest = md5.convert(bytes);

    // String url = "http://localhost:8080/users/login";
    // var res = await http.post(
    //   Uri.parse(url),
    //   headers: {
    //     // "Access-Control-Allow-Origin": "http://localhost:63892",
    //     // "Access-Control-Allow-Credentials": "true",
    //     "Accept": "application/json",
    //     'Content-Type': 'application/json;charset=utf-8'
    //   },
    //   // headers: {"Accept": "application/json"},
    //   body: jsonEncode({"username": username, "password": password}),
    // );
    // print(res.body);
    // var json = jsonDecode(res.body) as List;
    // return json;
    // String url = "http://localhost:8080/users/login";
    // try {
    //   var res = await http.post(
    //     Uri.parse(url),
    //     headers: {"Accept": "application/json"},
    //     body: {"username": username, "password": password},
    //   );
    //   print(res.statusCode);
    // } catch (e) {
    //   print('Error: $e');
    // }
    // return res.body;

    String query =
        "SELECT * FROM AdminUser WHERE `username`='$username' AND `password`='$digest'";
    String body = await select(query);
    //print(body);
    return jsonDecode(body)['table_data'] as List;
  }

  static registerAdmin(AdminUser user) async {
    var bytes = utf8.encode(user.password); //transforma a senha em hash

    var digest = md5.convert(bytes);

    String query =
        "INSERT INTO `AdminUser`(`name`, `username`, `password`, `email`, `userType`) VALUES (" +
            "'${user.name}', '${user.username}', '$digest','${user.email}', 'basic')";
    await insert(query);
    //print(query);
  }

  static getMaxLength(String table, String column) async {
    String query =
        "SELECT character_maximum_length FROM information_schema.columns WHERE table_name = '" +
            table +
            "' AND COLUMN_NAME='" +
            column +
            "'";

    String body = await select(query);
    var json = jsonDecode(body)['table_data'];

    MaxLength maxLength = MaxLength.fromJson(json[0]);
    //print("$column: ${maxLength.character_maximum_length}");
    return maxLength.CHARACTER_MAXIMUM_LENGTH;
  }

  static select(String query) async {
    String url = "https://v1.begapp.com.br/select.php";
    var res = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    return res.body;
  }

  static update(String query) async {
    String url = "https://v1.begapp.com.br/select.php";
    var res = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    return res.body;
  }

  static insert(String query) async {
    String url = "https://v1.begapp.com.br/insert.php";
    var res = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    return res.body;
  }

  static getRequests() async {
    String query = "SELECT * FROM `admin_user_request` WHERE `approved`=false";
    var body = await select(query);
    return jsonDecode(body)['table_data'] as List;
  }

  static getParticipant(int id) async {
    String query = "SELECT * FROM users WHERE `id` = '$id'";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getParticipants(String key) async {
    String query = "SELECT * FROM users WHERE `experiment` = '$key'";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getPublicGoodsExperiments() async {
    localStorage = await SharedPreferences.getInstance();
    String query;
    if (localStorage.get('userType') == 'master')
      query = "SELECT * FROM config_publicgoods";
    else
      query =
          "SELECT * FROM config_publicgoods WHERE `adminId` = '${localStorage.get('username')}' OR `publicConfig`=1";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getPublicGoodsExperiment(String key) async {
    String query = "SELECT * FROM config_publicgoods WHERE `key`='$key' ";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getDilemmaExperiments() async {
    localStorage = await SharedPreferences.getInstance();
    String query;
    if (localStorage.get('userType') == 'master')
      query = "SELECT * FROM config_dilemma";
    else
      query =
          "SELECT * FROM config_dilemma WHERE `adminId` = '${localStorage.get('username')}' OR `publicConfig`=1";
    String body = await select(query);
    //print(body);

    return jsonDecode(body)['table_data'] as List;
  }

  static getDilemmaExperiment(String key) async {
    String query = "SELECT * FROM config_dilemma WHERE `key`='$key'";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static search(String table, String colunm, String value) async {
    String query =
        "SELECT * FROM `$table` WHERE `$colunm` LIKE '%$value%' AND `approved` = false";
    String body = await select(query);
    return jsonDecode(body)['table_data'] as List;
  }

  static searchDilemmaExperiments(
      String colunm, String value, bool active) async {
    localStorage = await SharedPreferences.getInstance();
    String query;
    if (localStorage.get('userType') == 'master')
      query =
          "SELECT * FROM config_dilemma WHERE `$colunm` LIKE '%$value%' AND `active`=$active";
    else
      query =
          "SELECT * FROM config_dilemma WHERE `$colunm` LIKE '%$value%' AND (`adminId` = '${localStorage.get('username')}' OR `publicConfig`=1) AND `active`=$active";
    String body = await select(query);
    //print(query);
    //print(body);
    return jsonDecode(body)['table_data'] as List;
  }

  static searchPGExperiments(String colunm, String value, bool active) async {
    localStorage = await SharedPreferences.getInstance();
    String query;
    if (localStorage.get('userType') == 'master')
      query =
          "SELECT * FROM config_publicgoods WHERE `$colunm` LIKE '%$value%' AND `active`=$active";
    else
      query =
          "SELECT * FROM config_publicgoods WHERE `$colunm` LIKE '%$value%' AND (`adminId` = '${localStorage.get('username')}' OR `publicConfig`=1) AND `active`=$active";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getPgParticipants(String key) async {
    String query =
        " SELECT t.user_id as userId,u.age,u.gender,u.occupation,u.educationLevel,u.cours,u.experiment,t.total,t.tutorial_main as tutorialMain,t.tutorial_distribution as tutorialDistribution,t.tutorial_election as tutorialElection,t.saw_main_tutorial as sawMainTutorial,t.saw_distribution_tutorial as sawDistributionTutorial,t.saw_election_tutorial as sawElectionTutorial FROM users u INNER JOIN time_taken_tutorial_pg t on u.id=t.user_id WHERE u.experiment='$key' "; //OR u.experiment='pg2b' OR u.experiment='pg2c'";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getDilemmaParticipants(String key) async {
    String query =
        "SELECT t.user_id as userId,u.age,u.gender,u.occupation,u.educationLevel,u.cours,u.experiment,t.total,t.tutorial,t.saw_tutorial as sawTutorial FROM users u INNER JOIN time_taken_tutorial_pd t on u.id=t.user_id WHERE u.experiment='$key' ";
    String body = await select(query);
    return jsonDecode(body)['table_data'] as List;
  }

  static getPgParticipantsData(String experiment) async {
    String query =
        "SELECT r.userId,r.round,r.investment,r.positionToken,r.earning,r.rib,r.wallet,r.distribution,r.suspended,r.electionCount,r.votes,t.drag_token as dragToken,t.distribution as distributionTime,t.election as electionTime FROM public_goods_rounds r inner join time_taken_round_pg t on t.user_id=r.userId INNER JOIN `users` u ON t.user_id=u.id WHERE u.experiment='$experiment' AND r.round=t.round ORDER by r.userId, r.round";
    String body = await select(query);
    // //print(query);
    return jsonDecode(body)['table_data'] as List;
  }

  static getDilemmaParticipantsData(String experiment) async {
    String query =
        "SELECT r.userId,r.round,r.computer,r.userChoice,r.otherPoints,r.userPoints,r.lostRound,r.sawOtherPoints,r.sawYourPoints,t.drag_card as dragCard FROM dilemma_rounds r inner join time_taken_round_pd t on t.user_id=r.userId INNER JOIN `users` u ON t.user_id=u.id WHERE u.experiment='$experiment' AND r.round=t.round ORDER by r.userId,r.round";
    //print(query);
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getPgParticipantData(int userId) async {
    String query =
        "SELECT r.userId,r.round,r.investment,r.positionToken,r.earning,r.rib,r.wallet,r.distribution,r.suspended,r.electionCount,r.votes,t.drag_token as dragToken,t.distribution as distributionTime,t.election as electionTime FROM public_goods_rounds r inner join time_taken_round_pg t on t.user_id=r.userId WHERE t.user_id=$userId and r.round=t.round ORDER by r.round";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getDilemmaParticipantData(int userId) async {
    String query =
        "SELECT r.userId,r.round,r.computer,r.userChoice,r.otherPoints,r.userPoints,r.lostRound,r.sawOtherPoints,r.sawYourPoints,t.drag_card as dragCard FROM dilemma_rounds r inner join time_taken_round_pd t on t.user_id=r.userId WHERE t.user_id=$userId and r.round=t.round ORDER by r.round";
    //print(query);
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getPgParticipantDataTime(int userId) async {
    String query =
        "SELECT t.user_id as userId,u.age,u.gender,u.occupation,u.educationLevel,u.cours,u.experiment,t.total,t.tutorial_main as tutorialMain,t.tutorial_distribution as tutorialDistribution,t.tutorial_election as tutorialElection,t.saw_main_tutorial as sawMainTutorial,t.saw_distribution_tutorial as sawDistributionTutorial,t.saw_election_tutorial as sawElectionTutorial FROM users u INNER JOIN time_taken_tutorial_pg t on u.id=t.user_id WHERE u.id=$userId";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static getDilemmaParticipantDataTime(int userId) async {
    String query =
        "SELECT t.user_id as userId,u.age,u.gender,u.occupation,u.educationLevel,u.cours,u.experiment,t.total,t.tutorial,t.saw_tutorial as sawTutorial FROM users u INNER JOIN time_taken_tutorial_pd t on u.id=t.user_id WHERE u.id=$userId";
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static upadatePGConfig(PublicGoodsVariables config) async {
    // var f = new DateFormat('dd-MM-yyyy');
    String query = "UPDATE `config_publicgoods` SET `key` = '" +
        config.key +
        "',maxChips = " +
        config.maxTokens.toString() +
        ",time = " +
        config.time.toString() +
        ", `name` = '" +
        config.name +
        "', `start` = '" +
        config.start.toString() +
        "' WHERE `config_publicgoods`.`id`=" +
        config.id.toString() +
        ";";
    String url = "https://v1.begapp.com.br/select.php";
    //var res =
    await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    //print(query);
    //return res.body;
  }

  static changeStatusPG(bool active, String key) {
    String query =
        "UPDATE `config_publicgoods` SET `active`=$active WHERE `key`='$key'";
    update(query);
  }

  static createPGExperiment(PublicGoodsVariables variables, String eRule,
      {PopUpMessagePublicGoods? message}) async {
    // var f = new DateFormat('dd-MM-yyyy');
    String query;
    variables.key = await generateKey('config_publicgoods');

    query = "INSERT INTO `config_publicgoods`(`adminId`, `publicConfig`, `publicData`, `key`, `maxTokens`," +
        " `onlyContribution`,  `time`, `factor`, `maxTrys`, `realPlayers`, `notRealPlayers`, `name`, `descri`, " +
        " `showRounds`, `timeDistribution`, `timeElection`, `contributionsVariation`, `distributionVariation`," +
        " `unfairDistribution`, `stable`, `limitVotes`, `waitingRounds`, `electionRule`) " +
        "VALUES (" +
        "'${localStorage.get('username')}'," +
        "${variables.publicConfig}," +
        "${variables.publicData}," +
        "'${variables.key}'," +
        "${variables.maxTokens}," +
        "${variables.onlyContribution}," +
        "${variables.time}," +
        "${variables.factor}," +
        "${variables.maxTrys}," +
        "${variables.realPlayers}," +
        "${variables.notRealPlayers}," +
        "'${variables.name}'," +
        "'${variables.descri}'," +
        "${variables.showRounds}," +
        "${variables.timeDistribution}," +
        "${variables.timeElection}," +
        "${variables.contributionsVariation}," +
        "${variables.distributionVariation}," +
        "${variables.unfairDistribution}," +
        "${variables.stable}," +
        "${variables.limitVotes}," +
        "${variables.waitingRounds}," +
        "'$eRule'" +
        ");";

    if (message != null)
      query +=
          """ INSERT INTO `popup_message_pg`(`message`, `experiment`, `round`, `level`, `criterion`) VALUES (
            '${message.message}','${variables.key}',${message.round},${message.level},${message.criterion});
          """;

    String url = "https://v1.begapp.com.br/insert.php";
    await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    print(query);
    localStorage = await SharedPreferences.getInstance();
    localStorage.setString('newKey', variables.key);
    return variables.key;
  }

  static upadatePGExperiment(
      PublicGoodsVariables variables, String eRule) async {
    // var f = new DateFormat('dd-MM-yyyy');
    String query = "UPDATE `config_publicgoods` SET `maxTokens`=${variables.maxTokens},`time`=${variables.time}, " +
        "`factor`=${variables.factor},`maxTrys`=${variables.maxTrys},`notRealPlayers`=${variables.notRealPlayers}, " +
        "`name`='${variables.name}',`descri`='${variables.descri}',`start`='${variables.start}',`end`='${variables.end}'," +
        "`showRounds`=${variables.showRounds},`timeDistribution`='${variables.timeDistribution}'," +
        "`timeElection`='${variables.timeElection}',`contributionsVariation`='${variables.contributionsVariation}'," +
        "`distributionVariation`='${variables.distributionVariation}',`unfairDistribution`=${variables.unfairDistribution}," +
        "`stable`=${variables.stable},`limitVotes`=${variables.limitVotes},`waitingRounds`=${variables.waitingRounds}," +
        "`electionRule`='$eRule', `publicConfig`=${variables.publicConfig}, `publicData`=${variables.publicData}, " +
        "`onlyContribution` =${variables.onlyContribution}" +
        " WHERE `config_publicgoods`.`id`=" +
        variables.id.toString() +
        ";";
    query +=
        " UPDATE `popup_message_pg` SET `round`=${variables.maxTrys} WHERE `experiment`='${variables.key}' AND `criterion`=true;";

    print(query);
    String url = "https://v1.begapp.com.br/select.php";
    await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});

    return variables.key;
  }

  static changeStatusPD(bool active, String key) {
    String query =
        "UPDATE `config_dilemma` SET `active`=$active WHERE `key`='$key'";
    update(query);
  }

  static createPDExperiment(DilemmaVariables variables,
      {PopUpMessagePrisonersDilemma? message}) async {
    String query;
    variables.key = await generateKey('config_dilemma');

    query = "INSERT INTO `config_dilemma`(`adminId`, `publicConfig`, `publicData`, `key`, `algorithm`," +
        " `secondAlgorithm`, `dependentVariable`, `independentVariable`, `gameName`, `bothCooperate`, `bothDefect`," +
        " `cooperateLoses`, `defectWin`, `roundsNumber`, `maxTime`, `stable`, `showRounds`, `showClock`," +
        " `showYourPoints`, `showOtherPoints`, `yourPointsRand`, `otherPointsRand`,`formLink`) VALUES (" +
        "'${localStorage.get('username')}'," +
        "${variables.publicConfig}," +
        "${variables.publicData}," +
        "'${variables.key}'," +
        "'${variables.algorithm}'," +
        "'${variables.secondAlgorithm}'," +
        "'${variables.dependentVariable}'," +
        "'${variables.independentVariable}'," +
        "'${variables.gameName}'," +
        "${variables.bothCooperate}," +
        "${variables.bothDefect}," +
        "${variables.cooperateLoses}," +
        "${variables.defectWin}," +
        "${variables.roundsNumber}," +
        "${variables.maxTime}," +
        "${variables.stable}," +
        "${variables.showRounds}," +
        "${variables.showClock}," +
        "${variables.showYourPoints}," +
        "${variables.showOtherPoints}," +
        "${variables.yourPointsRand}," +
        "${variables.otherPointsRand}," +
        "'${variables.formLink}');";

    if (message != null)
      query +=
          """ INSERT INTO `popup_message_pd`(`message`, `experiment`, `round`) VALUES (
            '${message.message}','${variables.key}',${message.round});
          """;

    String url = "https://v1.begapp.com.br/insert.php";
    await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    print(query);
    localStorage = await SharedPreferences.getInstance();
    localStorage.setString('newKey', variables.key);
    return variables.key;
  }

  static upadatePDExperiment(
    DilemmaVariables variables,
  ) async {
    // var f = new DateFormat('dd-MM-yyyy');
    String query = "UPDATE `config_dilemma` SET `algorithm`='${variables.algorithm}',`gameName`='${variables.gameName}'," +
        "`bothCooperate`=${variables.bothCooperate},`bothDefect`=${variables.bothDefect},`cooperateLoses`=${variables.cooperateLoses}," +
        "`defectWin`=${variables.defectWin},`roundsNumber`=${variables.roundsNumber},`maxTime`=${variables.maxTime}," +
        "`stable`=${variables.stable},`showRounds`=${variables.showRounds},`showClock`=${variables.showClock}," +
        "`showYourPoints`=${variables.showYourPoints},`showOtherPoints`=${variables.showOtherPoints}," +
        "`yourPointsRand`=${variables.yourPointsRand},`otherPointsRand`=${variables.otherPointsRand}," +
        "`start`='${variables.start}',`end`='${variables.end}',`secondAlgorithm`='${variables.secondAlgorithm}'," +
        "`dependentVariable`='${variables.dependentVariable}', `independentVariable`='${variables.independentVariable}',"
            "`publicConfig`=${variables.publicConfig}, `publicData`=${variables.publicData},`formLink`='${variables.formLink}'"
            " WHERE `config_dilemma`.`id`=" +
        variables.id.toString() +
        ";";

    String url = "https://v1.begapp.com.br/select.php";
    await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    return variables.key;
    //  //print(query);
  }

  static getPopUpMessages(String experimentKey) async {
    var body = await Database.select(
        "SELECT * FROM `popup_message_pg` WHERE `experiment`='$experimentKey'");
    return jsonDecode(body)['table_data'] as List;
  }

  static getPopUpMessagesDilemma(String experimentKey) async {
    var body = await Database.select(
        "SELECT * FROM `popup_message_pd` WHERE `experiment`='$experimentKey'");
    print(body);
    return jsonDecode(body)['table_data'] as List;
  }

  static generateKey(String table) async {
    String experiment = "";
    switch (table) {
      case "config_dilemma":
        experiment = "pd";
        break;
      case "config_publicgoods":
        experiment = "pg";
        break;
      default:
    }
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var bytes = utf8.encode(timestamp); //transforma a senha em hash

    var digest = md5.convert(bytes);
    String newKey = experiment + digest.toString().substring(0, 5);
    //print(newKey);
    String body = await select(
        "SELECT 1 FROM " + table + " WHERE `key`='" + newKey + "'");
    //print(body);
    var keys = jsonDecode(body)['table_data'] as List;
    //print(keys.length);
    if (keys.length > 0) newKey = await generateKey(table);
    return newKey;
  }

  static requestRegisterNewUser(AdminUserRequest adminUserRequest) {
    String query =
        "INSERT INTO `admin_user_request`(`name`, `email`, `intention`, `approved`,`lang`) VALUES ('${adminUserRequest.name}','${adminUserRequest.email}','${adminUserRequest.intention}', false,'${adminUserRequest.lang}')";
    insert(query);
  }

  static Future makeRequest(List<int> _selectedFile, String fileName) async {
    var url = Uri.parse("https://v1.begapp.com.br/upload.php");
    // var url = Uri.parse("http://localhost/pdf/teste.php");

    var request = new http.MultipartRequest("POST", url);

    var file = http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: fileName);

    request.files.add(file);

    request.send().then((response) async {
      // print(response.statusCode);
      // print(await response.stream.bytesToString());
      if (response.statusCode == 200) print("Uploaded!");
    });
  }
}
