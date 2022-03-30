import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/popup_message_pg.dart';
import 'package:begapp_web/forms/DropDownField.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/modals/CreateMessage.dart';
import 'package:begapp_web/widgets/uploadPdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreatePGExperiment extends StatefulWidget {
  static const routeName = '/Public_Goods_Create_Experiment';
  final PublicGoodsVariables defaultVariables;

  const CreatePGExperiment({Key? key, required this.defaultVariables})
      : super(key: key);
  @override
  _CreatePGExperimentState createState() => _CreatePGExperimentState();
}

class _CreatePGExperimentState extends State<CreatePGExperiment> {
  late PublicGoodsVariables defaultVariables;
  final _formKey = GlobalKey<FormState>();
  List<String> electionRules = [
    "intermittent election disabled",
    "intermittent election enabled",
    "recurring election disabled",
    "recurring election enabled"
  ];
  String rule = "";
  bool electionAndDistribution = false;
  bool showRounds = false;
  bool publicConfig = false;
  bool publicData = false;
  double labelSize = 0;
  int intLength = 11;

  var txtExperimentName = new TextEditingController();
  var txtDesc = new TextEditingController();
  var txtMaxTokens = new TextEditingController();
  var txtFactor = new TextEditingController();
  var txtMaxTrys = new TextEditingController();
  var txtPlayers = new TextEditingController();
  var txtTime = new TextEditingController();
  var txtTimeDistribution = new TextEditingController();
  var txtTimeElection = new TextEditingController();
  var txtStable = new TextEditingController();
  var txtLimiteVotes = new TextEditingController();
  var txtSuspended = new TextEditingController();
  var txtContributionVariation = new TextEditingController();
  var txtDistributionVariation = new TextEditingController();
  var txtUnfairDistribution = new TextEditingController();
  var maskFormatter =
      new MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

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

  PopUpMessagePublicGoods? popUpMessage;
  setPopUpMessage(PopUpMessagePublicGoods message) {
    popUpMessage = message;
  }

  List<int>? _selectedFile;

  getSelectedFile(List<int> file) {
    _selectedFile = file;
  }

  @override
  void initState() {
    defaultVariables = widget.defaultVariables;

    txtExperimentName.text = defaultVariables.name;
    txtDesc.text = defaultVariables.descri;
    txtMaxTokens.text = defaultVariables.maxTokens.toString();
    txtFactor.text = defaultVariables.factor.toString();
    txtMaxTrys.text = defaultVariables.maxTrys.toString();
    txtPlayers.text = defaultVariables.notRealPlayers.toString();
    txtTime.text = defaultVariables.time.toString();
    txtTimeDistribution.text = defaultVariables.timeDistribution.toString();
    txtTimeElection.text = defaultVariables.timeElection.toString();
    txtStable.text = defaultVariables.stable.toString();
    txtLimiteVotes.text = defaultVariables.limitVotes.toString();
    txtSuspended.text = defaultVariables.waitingRounds.toString();
    txtContributionVariation.text =
        defaultVariables.contributionsVariation.toString();
    txtDistributionVariation.text =
        defaultVariables.distributionVariation.toString() + "%";
    txtUnfairDistribution.text =
        defaultVariables.unfairDistribution.toString() + "%";
    electionAndDistribution = !defaultVariables.onlyContribution;
    showRounds = defaultVariables.showRounds;
    publicConfig = defaultVariables.publicConfig;
    publicData = defaultVariables.publicData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    labelSize = MediaQuery.of(context).size.width * 0.015;
    List<String> rules =
        AppLocalizations.of(context).translate('electionRules').split(',');
    if (rule == "") rule = rules[defaultVariables.electionRule - 1];

    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      // physics: ScrollPhysics(),
                      child: GridView.count(
                          padding: EdgeInsets.all(20),
                          shrinkWrap: true,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 3.0,
                          crossAxisCount: 3,
                          childAspectRatio: 5,
                          children: [
                            TextFormField(
                              controller: txtExperimentName,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('experimentName')),
                              keyboardType: TextInputType.number,
                              maxLength: 100,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate('Required field');
                                }
                                return null;
                              },
                            ),
                            TextField(
                              maxLines: 2,
                              maxLength: 200,
                              controller: txtDesc,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('experimentDesc')),
                            ),
                            TextFormField(
                              controller: txtMaxTokens,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('maxTokens')),
                              keyboardType: TextInputType.number,
                              maxLength: intLength,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate('Required field');
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: txtFactor,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('factor')),
                              keyboardType: TextInputType.number,
                              maxLength: intLength,
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
                            TextFormField(
                              controller: txtPlayers,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('notRealPlayers')),
                              keyboardType: TextInputType.number,
                              maxLength: intLength,
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
                            TextFormField(
                              controller: txtTime,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('timePg')),
                              keyboardType: TextInputType.number,
                              maxLength: intLength,
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
                            TextFormField(
                              controller: txtContributionVariation,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('contributionsVariations')),
                              keyboardType: TextInputType.number,
                              maxLength: intLength,
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
                            TextFormField(
                              controller: txtStable,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('stable')),
                              keyboardType: TextInputType.number,
                              maxLength: intLength,
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
                            TextFormField(
                              controller: txtMaxTrys,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('maxTrys')),
                              keyboardType: TextInputType.number,
                              maxLength: intLength,
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
                            if (electionAndDistribution)
                              TextFormField(
                                controller: txtTimeDistribution,
                                decoration: setDecoration(
                                    AppLocalizations.of(context)
                                        .translate('timeDistribution')),
                                keyboardType: TextInputType.number,
                                maxLength: intLength,
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
                            if (electionAndDistribution)
                              TextFormField(
                                controller: txtTimeElection,
                                decoration: setDecoration(
                                    AppLocalizations.of(context)
                                        .translate('timeElection')),
                                keyboardType: TextInputType.number,
                                maxLength: intLength,
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
                            if (electionAndDistribution)
                              TextFormField(
                                controller: txtDistributionVariation,
                                decoration: setDecoration(
                                    AppLocalizations.of(context)
                                        .translate('distributionVariations')),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  maskFormatter,
                                ],
                                onChanged: (value) {
                                  if (value.length >= 2) {
                                    txtDistributionVariation.text =
                                        value.substring(0, 2) + "%";
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .translate('Required field');
                                  }
                                  return null;
                                },
                              ),
                            if (electionAndDistribution)
                              TextFormField(
                                controller: txtUnfairDistribution,
                                decoration: setDecoration(
                                    AppLocalizations.of(context)
                                        .translate('unfairDistriburion')),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  maskFormatter,
                                ],
                                onChanged: (value) {
                                  if (value.length >= 2) {
                                    txtUnfairDistribution.text =
                                        value.substring(0, 2) + "%";
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .translate('Required field');
                                  }
                                  return null;
                                },
                              ),
                            if (electionAndDistribution)
                              TextFormField(
                                controller: txtSuspended,
                                decoration: setDecoration(
                                    AppLocalizations.of(context)
                                        .translate('suspendedRounds')),
                                keyboardType: TextInputType.number,
                                maxLength: intLength,
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
                            if (electionAndDistribution)
                              TextFormField(
                                controller: txtLimiteVotes,
                                decoration: setDecoration(
                                    AppLocalizations.of(context)
                                        .translate('limitVotes')),
                                keyboardType: TextInputType.number,
                                maxLength: intLength,
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
                            if (electionAndDistribution)
                              DropDownField(
                                labelText: AppLocalizations.of(context)
                                    .translate('electionRule'),
                                value: rule,
                                items: rules,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    rule = newValue!;
                                  });
                                },
                              ),
                            Flex(direction: Axis.vertical, children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: electionAndDistribution,
                                    onChanged: (value) {
                                      setState(() {
                                        electionAndDistribution = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Incluir eleição e distribuição",
                                    // AppLocalizations.of(context)
                                    //     .translate('showRounds'),
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
                            ]),
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                // margin: EdgeInsets.all(22),
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
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: CreateMessage(
                                            widget.defaultVariables.maxTrys,
                                            setPopUpMessage));

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            createMessage);
                                  },
                                )),
                            UploadPdf(
                              getSelectedFile: getSelectedFile,
                            )
                          ]),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.08,
                      margin: EdgeInsets.symmetric(horizontal: 22),
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
                              PublicGoodsVariables variables = defaultVariables;
                              variables.name = txtExperimentName.text;
                              variables.descri = txtDesc.text;
                              variables.maxTokens =
                                  int.parse(txtMaxTokens.text);
                              variables.maxTrys = int.parse(txtMaxTrys.text);
                              variables.factor = int.parse(txtFactor.text);
                              variables.notRealPlayers =
                                  int.parse(txtPlayers.text);
                              variables.time = int.parse(txtTime.text);
                              variables.timeDistribution =
                                  int.parse(txtTimeDistribution.text);
                              variables.timeElection =
                                  int.parse(txtTimeElection.text);
                              variables.contributionsVariation =
                                  int.parse(txtContributionVariation.text);
                              variables.distributionVariation = int.parse(
                                  txtDistributionVariation.text
                                      .substring(0, 2));
                              variables.unfairDistribution = int.parse(
                                  txtUnfairDistribution.text.substring(0, 2));
                              variables.waitingRounds =
                                  int.parse(txtSuspended.text);
                              variables.stable = int.parse(txtStable.text);
                              variables.limitVotes =
                                  int.parse(txtLimiteVotes.text);
                              variables.showRounds = showRounds;
                              variables.publicConfig = publicConfig;
                              variables.publicData = publicData;
                              variables.onlyContribution =
                                  !electionAndDistribution;

                              variables.electionRule = rules.indexOf(rule);

                              String key = await Database.createPGExperiment(
                                  variables,
                                  electionRules[variables.electionRule],
                                  message: popUpMessage);
                              variables.electionRule++;
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
