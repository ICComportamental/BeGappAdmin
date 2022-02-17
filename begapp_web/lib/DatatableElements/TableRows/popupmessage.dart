import 'package:begapp_web/DatatableElements/TableRows/datatableRows.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/classes/popup_message_pg.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/modals/EditMessage.modal.dart';
import 'package:flutter/material.dart';

List<DataCell> getPopUpMessage(
    PopUpMessagePublicGoods popUpMessage, index, contextDialog, setstate) {
  List<DataCell> row = [];
  List<String> datas = [
    (index).toString(),
    popUpMessage.message,
    popUpMessage.experiment,
    popUpMessage.round.toString(),
    popUpMessage.level.toString(),
  ];

  datas.forEach((e) => row.add(DatatableRows.getCell(e)));
  row.add(DatatableRows.getEditCell(
      condition: true, //experiment.adminId == localStorage.get('username'),
      edit: () async {
        var snap =
            await Database.getPublicGoodsExperiment(popUpMessage.experiment);
        PublicGoodsVariables experiment =
            PublicGoodsVariables.fromJson(snap[0]);

        await Dialogs.showEditPopUpMessage(
            contextDialog, experiment, popUpMessage);
        setstate();
      }));
  row.add(DatatableRows.getDeleteCell(delete: () async {
    var snap = await Database.getPublicGoodsExperiment(popUpMessage.experiment);
    PublicGoodsVariables experiment = PublicGoodsVariables.fromJson(snap[0]);
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
                          "DELETE FROM `popup_message_pg` WHERE `id`=${popUpMessage.id}");

                      Navigator.of(contextDialog).pop();
                      Navigator.of(contextDialog).pop();
                      //força o refresh da tabela de mensagens
                      Dialog dialog = Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: EditMessageModal(
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
