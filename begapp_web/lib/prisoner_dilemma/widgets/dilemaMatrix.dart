import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class DilemmaMatrixForm extends StatefulWidget {
  DilemmaVariables variables;
  Function setPointsConfig;
  DilemmaMatrixForm(this.variables, this.setPointsConfig);
  @override
  _DilemmaMatrixFormState createState() => _DilemmaMatrixFormState();
}

class _DilemmaMatrixFormState extends State<DilemmaMatrixForm> {
  final _formKey = GlobalKey<FormState>();
  var txtBothCooperate = new TextEditingController();
  var txtBothDefect = new TextEditingController();
  var txtCooperateLoses = new TextEditingController();
  var txtDefectWin = new TextEditingController();
  bool p = false;
  bool showYourPoints = false;
  bool showYourPointsRand = false;
  bool showOtherPoints = false;
  bool showOtherPointsRand = false;

  @override
  void initState() {
    txtBothCooperate.text = widget.variables.bothCooperate.toString();
    txtBothDefect.text = widget.variables.bothDefect.toString();
    txtCooperateLoses.text = widget.variables.cooperateLoses.toString();
    txtDefectWin.text = widget.variables.defectWin.toString();
    showYourPoints = widget.variables.showYourPoints;
    showYourPointsRand = widget.variables.yourPointsRand;
    showOtherPoints = widget.variables.showOtherPoints;
    showOtherPointsRand = widget.variables.otherPointsRand;
    super.initState();
  }

  calculateProportion() {
    if (txtDefectWin.text == "") return;
    int maxValue = int.parse(txtDefectWin.text);
    int bothCooperate = (0.85 * maxValue).toInt();
    int bothDefect = (0.33 * maxValue).ceil();
    int minValue = (0.17 * maxValue).toInt();
    // int minValue = (0.17 * maxValue).toInt();
    // double bothCooperate = (0.85 * maxValue);
    // double bothDefect = (0.33 * maxValue);
    // double minValue = (0.17 * maxValue);

    if (p) {
      txtCooperateLoses.text = minValue.toString();
      txtBothDefect.text = bothDefect.toString();
      txtBothCooperate.text = bothCooperate.toString();
    }
  }

  checkConflict() {
    int maxValue = int.parse(txtDefectWin.text);
    int bothCooperate = int.parse(txtBothCooperate.text);
    int bothDefect = int.parse(txtBothDefect.text);
    //int minValue = int.parse(txtCooperateLoses.text);

    double formula = (maxValue + bothDefect) / 2;
    if (formula < bothCooperate) {
      print("Conflito");
      widget.setPointsConfig(
          int.parse(txtBothCooperate.text),
          int.parse(txtBothDefect.text),
          int.parse(txtDefectWin.text),
          int.parse(txtCooperateLoses.text),
          showYourPoints,
          showOtherPoints,
          showYourPointsRand,
          showOtherPointsRand);
      Navigator.pop(context);
    } else {
      print("Não é conflito");
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                    // backgroundColor: Colors.black54,
                    title:
                        Text(AppLocalizations.of(context).translate('warning')),
                    content: Text(
                        AppLocalizations.of(context).translate('noConflict')),
                    actions: [
                      TextButton(
                        child:
                            Text(AppLocalizations.of(context).translate('yes')),
                        onPressed: () {
                          widget.setPointsConfig(
                              int.parse(txtBothCooperate.text),
                              int.parse(txtBothDefect.text),
                              int.parse(txtDefectWin.text),
                              int.parse(txtCooperateLoses.text),
                              showYourPoints,
                              showOtherPoints,
                              showYourPointsRand,
                              showOtherPointsRand);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child:
                            Text(AppLocalizations.of(context).translate('no')),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ]));
          });
    }
  }

  setDecoration() {
    return InputDecoration(
        counterText: "",
        labelStyle: TextStyle(fontSize: labelSize),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ));
  }

  late double labelSize;
  @override
  Widget build(BuildContext context) {
    labelSize = MediaQuery.of(context).size.width * 0.015;
    int intLength = 11;
    TextStyle header = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.015,
        fontWeight: FontWeight.bold);

    return Container(
        //color: Colors.blue[100],
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Form(
            key: _formKey,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    flex: 2,
                    child: GridView.count(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 2,
                      childAspectRatio: 10,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: showYourPoints,
                              onChanged: (value) {
                                setState(() {
                                  showYourPoints = value!;
                                  if (!value) showYourPointsRand = false;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('showYourPoints'),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.015),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: showYourPointsRand,
                              onChanged: (value) {
                                setState(() {
                                  if (showYourPoints)
                                    showYourPointsRand = value!;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('yourPointsRand'),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.015),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: showOtherPoints,
                              onChanged: (value) {
                                setState(() {
                                  showOtherPoints = value!;
                                  if (!value) showOtherPointsRand = false;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('showOtherPoints'),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.015),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: showOtherPointsRand,
                              onChanged: (value) {
                                setState(() {
                                  if (showOtherPoints)
                                    showOtherPointsRand = value!;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('otherPointsRand'),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.015),
                            ),
                          ],
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Checkbox(
                          value: p,
                          onChanged: (value) {
                            setState(() {
                              p = value!;
                              if (value) calculateProportion();
                            });
                          },
                        ),
                        Text(
                          "Usar proporção",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.015),
                        )
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: GridView.count(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(20),
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 0.0,
                              crossAxisCount: 2,
                              childAspectRatio: 6,
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('cooperate'),
                                    style: header,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('cooperate'),
                                    style: header,
                                  ),
                                ),
                                // Expanded(child:Center(child:Text(AppLocalizations.of(context).translate('cooperate')),)),
                                TextFormField(
                                  controller: txtBothCooperate,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: txtBothCooperate,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(20),
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 0.0,
                              crossAxisCount: 2,
                              childAspectRatio: 6,
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('defect'),
                                    style: header,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('cooperate'),
                                    style: header,
                                  ),
                                ),
                                TextFormField(
                                  controller: txtDefectWin,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: txtCooperateLoses,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(20),
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 0.0,
                              crossAxisCount: 2,
                              childAspectRatio: 6,
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('cooperate'),
                                    style: header,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('defect'),
                                    style: header,
                                  ),
                                ),
                                TextFormField(
                                  controller: txtCooperateLoses,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: txtDefectWin,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(20),
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 0.0,
                              crossAxisCount: 2,
                              childAspectRatio: 6,
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('defect'),
                                    style: header,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('defect'),
                                    style: header,
                                  ),
                                ),
                                TextFormField(
                                  controller: txtBothDefect,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: txtBothDefect,
                                  decoration: setDecoration(),
                                  maxLength: intLength,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (txt) => calculateProportion(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .translate('Required field');
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                        ),
                      ]),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: EdgeInsets.all(22),
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
                            if (!p)
                              checkConflict();
                            else {
                              widget.setPointsConfig(
                                  int.parse(txtBothCooperate.text),
                                  int.parse(txtBothDefect.text),
                                  int.parse(txtDefectWin.text),
                                  int.parse(txtCooperateLoses.text),
                                  showYourPoints,
                                  showOtherPoints,
                                  showYourPointsRand,
                                  showOtherPointsRand);
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text(
                            AppLocalizations.of(context).translate('confirm'),
                            style: TextStyle(
                              fontSize: labelSize,
                              color: Colors.white,
                            ))))
              ],
            )));
  }
}
