import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/forms/DropDownField.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/classes/popup_message_pd.dart';
import 'package:begapp_web/prisoner_dilemma/modals/CreateMessageDilemma.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/dilemaMatrix.dart';
import 'package:begapp_web/widgets/uploadPdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateDilemmaExperiment extends StatefulWidget {
  static const routeName = '/Public_Goods_Create_Experiment';
  final DilemmaVariables defaultVariables;

  const CreateDilemmaExperiment({Key? key, required this.defaultVariables})
      : super(key: key);
  @override
  _CreateDilemmaExperimentState createState() =>
      _CreateDilemmaExperimentState();
}

class _CreateDilemmaExperimentState extends State<CreateDilemmaExperiment> {
  final _formKey = GlobalKey<FormState>();
  late DilemmaVariables variables;
  List<String> algorithms = [
    "Tit For Tat",
    "Suspicious Tit For Tat",
    "Tit For Two Tats",
    "Pavlov",
    "Probabilities",
    "Cooperate",
    "Defect",
    "Random"
  ];
  String algorithm = "";
  String secondAlgorithm = "";
  bool showRounds = false;
  bool showClock = false;
  bool criterion = false;
  double labelSize = 0;
  bool publicConfig = false;
  bool publicData = false;

  var txtExperimentName = new TextEditingController();
  var txtDependentVariable = new TextEditingController();
  var txtIndependentVariable = new TextEditingController();
  var txtBothCooperate = new TextEditingController();
  var txtBothDefect = new TextEditingController();
  var txtCooperateLoses = new TextEditingController();
  var txtDefectWin = new TextEditingController();
  var txtTime = new TextEditingController();
  var txtStable = new TextEditingController();
  var txtRoundsNumber = new TextEditingController();
  var txtFormLink = new TextEditingController();

  var maskFormatter =
      new MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  @override
  void initState() {
    txtExperimentName.text = widget.defaultVariables.gameName;
    txtDependentVariable.text = widget.defaultVariables.dependentVariable;
    txtIndependentVariable.text = widget.defaultVariables.independentVariable;
    algorithm = widget.defaultVariables.algorithm;
    secondAlgorithm = widget.defaultVariables.secondAlgorithm;
    txtBothCooperate.text = widget.defaultVariables.bothCooperate.toString();
    txtBothDefect.text = widget.defaultVariables.bothDefect.toString();
    txtCooperateLoses.text = widget.defaultVariables.cooperateLoses.toString();
    txtDefectWin.text = widget.defaultVariables.defectWin.toString();
    txtTime.text = widget.defaultVariables.maxTime.toString();
    txtRoundsNumber.text = widget.defaultVariables.roundsNumber.toString();
    txtStable.text = widget.defaultVariables.stable.toString();
    txtFormLink.text = widget.defaultVariables.formLink;
    showRounds = widget.defaultVariables.showRounds;
    showClock = widget.defaultVariables.showClock;
    variables = widget.defaultVariables;
    criterion = (variables.stable != 0);
    publicConfig = widget.defaultVariables.publicConfig;
    publicData = widget.defaultVariables.publicData;

    super.initState();
  }

  setPointsConfig(
      int bothCooperate,
      int bothDefect,
      int defectWin,
      int cooperateLoses,
      bool your,
      bool other,
      bool yourRand,
      bool otherRand) {
    variables.bothCooperate = bothCooperate;
    variables.bothDefect = bothDefect;
    variables.defectWin = defectWin;
    variables.cooperateLoses = cooperateLoses;
    variables.showYourPoints = your;
    variables.showOtherPoints = other;
    variables.yourPointsRand = yourRand;
    variables.otherPointsRand = otherRand;
  }

  setDecoration(String label) {
    return InputDecoration(
        counterText: "",
        labelText: label,
        labelStyle: TextStyle(fontSize: labelSize),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ));
  }

  PopUpMessagePrisonersDilemma? popUpMessage;
  setPopUpMessage(PopUpMessagePrisonersDilemma message) {
    popUpMessage = message;
  }

  List<int>? _selectedFile = [];

  getSelectedFile(List<int> file) {
    _selectedFile = file;
  }

  @override
  Widget build(BuildContext context) {
    labelSize = MediaQuery.of(context).size.width * 0.015;

    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 10),
        child: Form(
            key: _formKey,
            child: Flex(direction: Axis.vertical, children: <Widget>[
              Expanded(
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: GridView.count(
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 0.0,
                      crossAxisCount: 3,
                      childAspectRatio: 4.5,
                      children: [
                        TextFormField(
                          controller: txtExperimentName,
                          maxLength: 100,
                          decoration: setDecoration(
                            AppLocalizations.of(context)
                                .translate('experimentName'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('Required field');
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: txtRoundsNumber,
                          maxLength: 11,
                          decoration: setDecoration(
                            AppLocalizations.of(context).translate('maxTrys'),
                          ),
                          keyboardType: TextInputType.number,
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
                        ),
                        DropDownField(
                          labelText: AppLocalizations.of(context)
                              .translate('algorithm'),
                          value: algorithm,
                          items: algorithms,
                          onChanged: (String? newValue) {
                            setState(() {
                              algorithm = newValue!;
                            });
                          },
                        ),

                        TextField(
                          maxLines: 2,
                          controller: txtDependentVariable,
                          maxLength: 100,
                          decoration: setDecoration(
                            AppLocalizations.of(context)
                                .translate('dependent variable'),
                          ),
                        ),
                        TextField(
                          maxLines: 2,
                          maxLength: 100,
                          controller: txtIndependentVariable,
                          decoration: setDecoration(
                            AppLocalizations.of(context)
                                .translate('independent variable'),
                          ),
                        ),
                        Flex(
                          direction: Axis.vertical,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: showRounds,
                                  onChanged: (value) {
                                    setState(() {
                                      showRounds = value!;
                                    });
                                  },
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('showRounds'),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.015),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: showClock,
                                  onChanged: (value) {
                                    setState(() {
                                      showClock = value!;
                                    });
                                  },
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('showClock'),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.015),
                                )
                              ],
                            ),
                          ],
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Checkbox(
                              value: criterion,
                              onChanged: (value) {
                                setState(() {
                                  criterion = value!;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("criterion"),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.015),
                            ),
                          ],
                        ),
                        Flex(
                          direction: Axis.vertical,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: publicConfig,
                                  onChanged: (value) {
                                    setState(() {
                                      publicConfig = value!;
                                    });
                                  },
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('publicConfig'),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.015),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: publicData,
                                  onChanged: (value) {
                                    setState(() {
                                      publicData = value!;
                                    });
                                  },
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('publicData'),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.015),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.08,
                            margin: EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              // border: Border.all(color: Colors.blueGrey) ,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            child: TextButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('score'),
                                  style: TextStyle(
                                    fontSize: labelSize,
                                    color: Colors.black,
                                  )),
                              onPressed: () {
                                Dialog dilemmaMatrix = Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: DilemmaMatrixForm(
                                        widget.defaultVariables,
                                        setPointsConfig));
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dilemmaMatrix);
                              },
                            )),
                        Opacity(
                            opacity: criterion ? 1 : 0,
                            child: Container(
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: txtStable,
                                maxLength: 11,
                                decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('stable'),
                                ),
                                keyboardType: TextInputType.number,
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
                              ),
                            )),
                        Opacity(
                          opacity: criterion ? 1 : 0,
                          child: Container(
                              alignment: Alignment.center,
                              child: DropDownField(
                                labelText: AppLocalizations.of(context)
                                    .translate('algorithm'),
                                value: secondAlgorithm,
                                items: algorithms,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    secondAlgorithm = newValue!;
                                  });
                                },
                              )),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.08,
                            margin: EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              // border: Border.all(color: Colors.blueGrey) ,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            child: TextButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('popGameMessage'),
                                  style: TextStyle(
                                    fontSize: labelSize,
                                    color: Colors.black,
                                  )),
                              onPressed: () {
                                Dialog createMessage = Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: CreateMessageDilemma(
                                        widget.defaultVariables.roundsNumber,
                                        setPopUpMessage));

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        createMessage);
                              },
                            )),
                        Container(
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: txtFormLink,
                            // maxLength: 255,
                            decoration: setDecoration(
                              AppLocalizations.of(context)
                                  .translate('formLink'),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)
                                    .translate('Required field');
                              }
                              return null;
                            },
                          ),
                        ),
                        UploadPdf(
                          getSelectedFile: getSelectedFile,
                        )
                        //     ]
                        //   )
                        // ),
                      ]),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.15,
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
                          variables.gameName = txtExperimentName.text;
                          variables.dependentVariable =
                              txtDependentVariable.text;
                          variables.algorithm = algorithm;
                          variables.secondAlgorithm = secondAlgorithm;
                          // variables.bothDefect = int.parse(txtBothDefect.text);
                          // variables.bothCooperate = int.parse(txtBothCooperate.text);
                          // variables.cooperateLoses = int.parse(txtCooperateLoses.text);
                          // variables.defectWin = int.parse(txtDefectWin.text);
                          variables.maxTime = int.parse(txtTime.text);
                          variables.roundsNumber =
                              int.parse(txtRoundsNumber.text);
                          variables.showRounds = showRounds;
                          variables.showClock = showClock;
                          variables.publicConfig = publicConfig;
                          variables.publicData = publicData;
                          variables.stable = int.parse(txtStable.text);
                          variables.formLink = txtFormLink.text;
                          if (!criterion) variables.stable = 0;

                          String key = await Database.createPDExperiment(
                              variables,
                              message: popUpMessage);
                          if (_selectedFile != null &&
                              _selectedFile!.isNotEmpty)
                            await Database.makeRequest(_selectedFile!, key);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                          AppLocalizations.of(context).translate('confirm'),
                          style: TextStyle(
                            fontSize: labelSize,
                            color: Colors.white,
                          ))))
            ])));
  }
}
