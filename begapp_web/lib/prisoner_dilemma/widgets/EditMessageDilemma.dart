import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/forms/DropDownField.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/classes/popup_message_pd.dart';
import 'package:begapp_web/prisoner_dilemma/modals/EditMessageDilemma.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart';

class EditMessageDilemma extends StatefulWidget {
  final DilemmaVariables variables;
  final PopUpMessagePrisonersDilemma popUpMessage;
  final Function? setPopUpMessage;

  const EditMessageDilemma(
      {Key? key,
      required this.variables,
      required this.popUpMessage,
      this.setPopUpMessage})
      : super(key: key);
  @override
  _EditMessageDilemmaState createState() => _EditMessageDilemmaState();
}

class _EditMessageDilemmaState extends State<EditMessageDilemma> {
  final _formKey = GlobalKey<FormState>();

  bool useNextLevelCriterion = false;

  double labelSize = 0;

  TextEditingController txtRound = new TextEditingController(text: "1");
  TextEditingController txtMessage = new TextEditingController();
  String level = "";
  List<String> levels = [];
  late PopUpMessagePrisonersDilemma message;
  @override
  void initState() {
    // TODO: implement initState
    message = widget.popUpMessage;
    txtMessage.text = message.message;
    txtRound.text = message.round.toString();
    // useNextLevelCriterion = message.criterion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    labelSize = MediaQuery.of(context).size.width * 0.015;
    // levels = [
    //   AppLocalizations.of(context).translate("contribution"),
    //   AppLocalizations.of(context).translate("distribution"),
    //   AppLocalizations.of(context).translate("election")
    // ];
    // if (level == "") level = levels[message.level - 1];
    setDecoration(String label) {
      return InputDecoration(
          // counterText: "",
          labelText: label,
          labelStyle: TextStyle(fontSize: labelSize),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ));
    }

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Form(
            key: _formKey,
            child: Flex(direction: Axis.vertical, children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Text(
                  AppLocalizations.of(context)
                      .translate("typeThePopUPMessage"), //.toUpperCase(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.02),
                ),
              ),
              TextFormField(
                maxLines: 2,
                maxLength: 200,
                controller: txtMessage,
                decoration: setDecoration(""),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('Required field');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: txtRound,
                maxLength: 11,
                decoration: setDecoration(
                    AppLocalizations.of(context).translate("roundToShow")),
                keyboardType: TextInputType.number,
                // maxLength: intLength,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('Required field');
                  }
                  return null;
                },
                onChanged: (value) {
                  if (int.parse(txtRound.text) >
                          widget.variables.roundsNumber ||
                      useNextLevelCriterion)
                    txtRound.text = widget.variables.roundsNumber.toString();
                },
              ),
              // DropDownField(
              //   labelText: AppLocalizations.of(context).translate('level'),
              //   value: level,
              //   items: levels,
              //   onChanged: (String newValue) {
              //     setState(() {
              //       level = newValue;
              //     });
              //   },
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(
              //     vertical: MediaQuery.of(context).size.height * 0.05,
              //   ),
              //   child: Flex(
              //     direction: Axis.vertical,
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: useNextLevelCriterion,
              //             onChanged: (value) {
              //               setState(() {
              //                 useNextLevelCriterion = value;
              //                 if (useNextLevelCriterion)
              //                   txtRound.text =
              //                       widget.variables.roundsNumber.toString();
              //               });
              //             },
              //           ),
              //           Text(
              //             AppLocalizations.of(context)
              //                 .translate('useNextLevel'),
              //             style: TextStyle(
              //                 fontSize:
              //                     MediaQuery.of(context).size.width * 0.015),
              //           )
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.08,
                      // margin: EdgeInsets.symmetric(horizontal: 22),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              message = PopUpMessagePrisonersDilemma(
                                message.id,
                                txtMessage.text,
                                message.experiment,
                                int.parse(txtRound.text),
                              );
                              // widget.setPopUpMessage(message);
                              await Database.update(
                                  "UPDATE `popup_message_pd` SET `message`='${message.message}',`round`=${message.round} WHERE `id`=${message.id}");
                              Navigator.pop(context);
                              Navigator.pop(
                                  context); //força o refresh da tabela de mensagens
                              Dialog createMessage = Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: EditMessageDilemmaModal(
                                    variables: widget.variables,
                                  ));

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      createMessage);
                            }
                          },
                          child:
                              Text(AppLocalizations.of(context).translate('ok'),
                                  style: TextStyle(
                                    fontSize: labelSize,
                                    color: Colors.white,
                                  )))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      child: TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              AppLocalizations.of(context).translate('cancel'),
                              style: TextStyle(
                                fontSize: labelSize,
                                color: Colors.white,
                              )))),
                ],
              )
            ])));
  }
}