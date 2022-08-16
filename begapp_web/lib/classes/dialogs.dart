import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/popup_message_pg.dart';
import 'package:begapp_web/login/classes/requestUserAdmin.dart';
import 'package:begapp_web/login/pages/RequestsPage.dart';
import 'package:begapp_web/login/widgets/RequestDetails.dart';
import 'package:begapp_web/main.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/classes/popup_message_pd.dart';
import 'package:begapp_web/prisoner_dilemma/modals/EditDilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/modals/createDilemmaExperiment.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/EditMessageDilemma.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/modals/EditPublicGoods.modal.dart';
import 'package:begapp_web/public_goods/modals/createExperiment.dart';
import 'package:begapp_web/public_goods/widgets/EditMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dialogs {
  static okDialog(String txt, context, {Function? onPop}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text(
                txt,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 30),
              ),
              actions: [
                TextButton(
                    onPressed: onPop != null
                        ? () => onPop()
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: Text(
                      AppLocalizations.of(context).translate('ok'),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30),
                    )),
              ],
            ));
  }

  static showSimpleCustomDialog(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                    decoration: InputDecoration(labelText: "subistituir"))),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  static showGeneratedKeyDialog(
    BuildContext context,
  ) async {
    double side = MediaQuery.of(context).size.longestSide * 0.2;
    localStorage = await SharedPreferences.getInstance();
    String key = localStorage.getString('newKey')!;
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: side,
        width: side,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: side * 0.1, vertical: side * 0.1),
                child: Text(
                  AppLocalizations.of(context).translate('newKey') + key,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: side * 0.1),
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: side * 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      // onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: key));
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('copyKey'),
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide * 0.03,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  static showMessageDialog(BuildContext context, String message,
      {Function? onPop}) async {
    double side = MediaQuery.of(context).size.longestSide * 0.2;
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: side,
        width: side,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: side * 0.1, vertical: side * 0.1),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: side * 0.1),
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: side * 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      // onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      if (onPop == null)
                        Navigator.of(context).pop();
                      else
                        onPop();
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('ok'),
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.longestSide * 0.025,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  static showRequests(BuildContext context) async {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        // height: side,
        // width: side,
        child: RequestsPage(),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  static showEditingDialog(BuildContext context, String variableName,
      String text, PublicGoodsVariables goodsVariables, Function function) {
    TextEditingController textEditingController =
        new TextEditingController(text: text);

    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: TextFormField(
                  autofocus: true,
                  controller: textEditingController,
                  // decoration:InputDecoration(labelText:"Novo nome")
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      switch (variableName) {
                        case 'name':
                          goodsVariables.name = textEditingController.text;
                          break;
                        case 'key':
                          goodsVariables.key = textEditingController.text;
                          break;
                        default:
                      }

                      await Database.upadatePGConfig(goodsVariables);
                      //print(goodsVariables.name);
                      function();
                      // return goodsVariables;
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  static showEditPublicGoodsExperiment(
      context, PublicGoodsVariables experiment) async {
    Dialog editPublicGoodsDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: EditPublicGoodsVariables(experiment));
    await showDialog(
        context: context,
        builder: (BuildContext context) => editPublicGoodsDialog);
  }

  static showAddPublicGoodsExperiment(context) async {
    var snap = await Database.getPublicGoodsExperiment('default');
    PublicGoodsVariables experiment = PublicGoodsVariables.fromJson(snap[0]);

    Dialog editPublicGoodsDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: CreatePGExperiment(defaultVariables: experiment));
    await showDialog(
        context: context,
        builder: (BuildContext context) => editPublicGoodsDialog);
  }

  static showEditDilemmaExperiment(
    context,
    DilemmaVariables experiment,
  ) async {
    Dialog dialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: EditDilemmaVariables(
          experiment,
        ));
    await showDialog(
        context: context, builder: (BuildContext context) => dialog);
  }

  static showAddDilemmaExperiment(
    context,
  ) async {
    var snap = await Database.getDilemmaExperiment('default');
    DilemmaVariables experiment = DilemmaVariables.fromJson(snap[0]);

    Dialog dialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: CreateDilemmaExperiment(
          defaultVariables: experiment,
        ));
    await showDialog(
        context: context, builder: (BuildContext context) => dialog);
  }

  static showRequestsDetails(context, AdminUserRequest request) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Dialog dialog = Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: width * 0.25, vertical: height * 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: RequestDetails(request));
    await showDialog(
        context: context, builder: (BuildContext context) => dialog);
  }

  static showEditPopUpMessage(context, PublicGoodsVariables variables,
      PopUpMessagePublicGoods popUpMessage) async {
    Dialog dialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: EditMessage(
          variables: variables,
          popUpMessage: popUpMessage,
        ));
    await showDialog(
        context: context, builder: (BuildContext context) => dialog);
  }

  static showEditPopUpMessageDilemma(context, DilemmaVariables variables,
      PopUpMessagePrisonersDilemma popUpMessage) async {
    Dialog dialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: EditMessageDilemma(
          variables: variables,
          popUpMessage: popUpMessage,
        ));
    await showDialog(
        context: context, builder: (BuildContext context) => dialog);
  }
}
