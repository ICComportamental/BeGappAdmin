import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/popup_message_pg.dart';
import 'package:begapp_web/forms/DropDownField.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/modals/EditMessage.modal.dart';
import 'package:begapp_web/widgets/uploadPdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditPublicGoodsVariables extends StatefulWidget {
  final PublicGoodsVariables variables;
  EditPublicGoodsVariables(this.variables);
  @override
  _EditPublicGoodsVariablesState createState() =>
      _EditPublicGoodsVariablesState();
}

class _EditPublicGoodsVariablesState extends State<EditPublicGoodsVariables> {
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
  List<PopUpMessagePublicGoods> messages = [];

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
        labelText: label,
        counterText: "",
        labelStyle: TextStyle(fontSize: labelSize),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ));
  }

  @override
  void initState() {
    txtExperimentName.text = widget.variables.name;
    txtDesc.text = widget.variables.descri;
    txtMaxTokens.text = widget.variables.maxTokens.toString();
    txtFactor.text = widget.variables.factor.toString();
    txtMaxTrys.text = widget.variables.maxTrys.toString();
    txtPlayers.text = widget.variables.notRealPlayers.toString();
    txtTime.text = widget.variables.time.toString();
    txtTimeDistribution.text = widget.variables.timeDistribution.toString();
    txtTimeElection.text = widget.variables.timeElection.toString();
    txtStable.text = widget.variables.stable.toString();
    txtLimiteVotes.text = widget.variables.limitVotes.toString();
    txtSuspended.text = widget.variables.waitingRounds.toString();
    txtContributionVariation.text =
        widget.variables.contributionsVariation.toString();
    txtDistributionVariation.text =
        widget.variables.distributionVariation.toString() + "%";
    txtUnfairDistribution.text =
        widget.variables.unfairDistribution.toString() + "%";
    showRounds = widget.variables.showRounds;
    electionAndDistribution = !widget.variables.onlyContribution;
    publicConfig = widget.variables.publicConfig;
    publicData = widget.variables.publicData;

    super.initState();
  }

  late List<int> _selectedFile;

  getSelectedFile(List<int> file) {
    _selectedFile = file;
  }

  @override
  Widget build(BuildContext context) {
    labelSize = MediaQuery.of(context).size.width * 0.015;
    List<String> rules =
        AppLocalizations.of(context).translate('electionRules').split(',');

    if (rule == "") rule = rules[widget.variables.electionRule - 1];

    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 10),
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
                                    .translate('experimentName'),
                              ),
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
                              controller: txtDesc,
                              maxLength: 200,
                              decoration: setDecoration(
                                AppLocalizations.of(context)
                                    .translate('experimentDesc'),
                              ),
                            ),
                            TextFormField(
                              controller: txtMaxTokens,
                              decoration: setDecoration(
                                AppLocalizations.of(context)
                                    .translate('maxTokens'),
                              ),
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
                                    .translate('factor'),
                              ),
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
                                    .translate('notRealPlayers'),
                              ),
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
                                    .translate('timePg'),
                              ),
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
                                    .translate('contributionsVariations'),
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
                            TextFormField(
                              controller: txtStable,
                              decoration: setDecoration(
                                AppLocalizations.of(context)
                                    .translate('stable'),
                              ),
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
                                    .translate('maxTrys'),
                              ),
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
                                      .translate('timeDistribution'),
                                ),
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
                                      .translate('timeElection'),
                                ),
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
                                      .translate('distributionVariations'),
                                ),
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
                                      .translate('unfairDistriburion'),
                                ),
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
                                      .translate('suspendedRounds'),
                                ),
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
                                      .translate('limitVotes'),
                                ),
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
                                  onPressed: () async {
                                    // var body = await Database.select(
                                    //     "SELECT * FROM `popup_message_pg` WHERE `experiment`='${widget.variables.key}'");
                                    // var list =
                                    //     jsonDecode(body)['table_data'] as List;
                                    // messages = [];
                                    // for (var i = 0; i < list.length; i++) {
                                    //   messages
                                    //       .add(PopUpMessage.fromJson(list[i]));
                                    // }
                                    Dialog createMessage = Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: EditMessageModal(
                                          variables: widget.variables,
                                        ));

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
                              PublicGoodsVariables variables = widget.variables;
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

                              String key = await Database.upadatePGExperiment(
                                  variables,
                                  electionRules[variables.electionRule]);
                              variables.electionRule++;
                              if (_selectedFile.isNotEmpty)
                                await Database.makeRequest(_selectedFile, key);
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
