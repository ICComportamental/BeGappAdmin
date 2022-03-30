import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/prisoner_dilemma/classes/popup_message_pd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CreateMessageDilemma extends StatefulWidget {
  final int maxTrys;
  Function setPopUpMessage;
  CreateMessageDilemma(this.maxTrys, this.setPopUpMessage);
  @override
  _CreateMessageDilemmaState createState() => _CreateMessageDilemmaState();
}

class _CreateMessageDilemmaState extends State<CreateMessageDilemma> {
  final _formKey = GlobalKey<FormState>();

  bool useNextLevelCriterion = false;

  double labelSize = 0;

  TextEditingController txtRound = new TextEditingController(text: "1");
  TextEditingController txtMessage = new TextEditingController();
  String level = "";
  List<String> levels = [];

  @override
  Widget build(BuildContext context) {
    labelSize = MediaQuery.of(context).size.width * 0.015;
    if (level == "")
      level = AppLocalizations.of(context).translate("contribution");
    levels = [
      AppLocalizations.of(context).translate("contribution"),
      AppLocalizations.of(context).translate("distribution"),
      AppLocalizations.of(context).translate("election")
    ];
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
                  if (int.parse(txtRound.text) > widget.maxTrys ||
                      useNextLevelCriterion)
                    txtRound.text = widget.maxTrys.toString();
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
              //                   txtRound.text = widget.maxTrys.toString();
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
                              PopUpMessagePrisonersDilemma m =
                                  PopUpMessagePrisonersDilemma(
                                0,
                                txtMessage.text,
                                "",
                                int.parse(txtRound.text),
                                // levels.indexOf(level) + 1,
                              );
                              widget.setPopUpMessage(m);
                              Navigator.pop(context);
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
                            Navigator.pop(context);
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
