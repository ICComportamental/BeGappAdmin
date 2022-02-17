import 'package:begapp_web/DatatableElements/TableRows/datatableRows.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/classes/popup_message_pd.dart';
import 'package:begapp_web/prisoner_dilemma/modals/EditMessageDilemma.modal.dart';
import 'package:flutter/material.dart';

List<DataCell> getPopUpMessageDilemma(
    PopUpMessagePrisonersDilemma popUpMessage, index, contextDialog, setstate) {
  List<DataCell> row = [];
  List<String> datas = [
    (index).toString(),
    popUpMessage.message,
    popUpMessage.experiment,
    popUpMessage.round.toString(),
    // popUpMessage.level.toString(),
  ];

  datas.forEach((e) => row.add(DatatableRows.getCell(e)));
  row.add(DatatableRows.getEditCell(
      condition: true, //experiment.adminId == localStorage.get('username'),
      edit: () async {
        var snap = await Database.getDilemmaExperiment(popUpMessage.experiment);
        DilemmaVariables experiment = DilemmaVariables.fromJson(snap[0]);

        await Dialogs.showEditPopUpMessageDilemma(
            contextDialog, experiment, popUpMessage);
        setstate();
      }));
  row.add(DatatableRows.getDeleteCell(delete: () async {
    var snap = await Database.getDilemmaExperiment(popUpMessage.experiment);
    DilemmaVariables experiment = DilemmaVariables.fromJson(snap[0]);
    showDialog(
        context: contextDialog,
        builder: (_) => AlertDialog(
              content: Text(
                AppLocalizations.of(contextDialog).translate('deleteMessage'),
                // style: TextStyle(fontSize: fontsize * 1.5),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      await Database.select(
                          "DELETE FROM `popup_message_pd` WHERE `id`=${popUpMessage.id}");

                      Navigator.of(contextDialog).pop();
                      Navigator.of(contextDialog).pop();
                      //força o refresh da tabela de mensagens
                      Dialog dialog = Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: EditMessageDilemmaModal(
                            variables: experiment,
                          ));

                      showDialog(
                          context: contextDialog,
                          builder: (BuildContext context) => dialog);
                    },
                    child: Text(
                      AppLocalizations.of(contextDialog).translate('yes'),
                      // style: TextStyle(fontSize: fontsize * 1.5),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(contextDialog).pop();
                    },
                    child: Text(
                      AppLocalizations.of(contextDialog).translate('no'),
                      // style: TextStyle(fontSize: fontsize * 1.5),
                    ))
              ],
            ));
  }));
  return row;
}
