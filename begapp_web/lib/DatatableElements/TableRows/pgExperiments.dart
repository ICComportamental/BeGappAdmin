import 'package:begapp_web/DatatableElements/TableRows/datatableRows.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/classes/excel.dart';
import 'package:begapp_web/main.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/classes/pgparticipant.dart';
import 'package:begapp_web/public_goods/pages/PGParticipants.dart';
import 'package:flutter/material.dart';

List<DataCell> getPGExperiment(
    PublicGoodsVariables experiment, index, contextDialog, setstate) {
  List<DataCell> row = [];
  List<String> datas = [
    (index).toString(),
    experiment.name,
    experiment.key,
    experiment.adminId,
    experiment.descri,
    // "",
    // "",
    // "",
  ];
  datas.forEach((e) => row.add(DatatableRows.getCell(e)));
  row.forEach((e) => print(e.child));

  row.add(DatatableRows.getEditCell(
      condition: experiment.adminId == localStorage.get('username'),
      edit: () async {
        await Dialogs.showEditPublicGoodsExperiment(contextDialog, experiment);
        setstate();
      }));

  row.add(DatatableRows.getSeeCell(
      condition: (experiment.adminId == localStorage.get('username') ||
          experiment.publicData ||
          localStorage.get('userType') == "master"),
      seeData: () {
        Navigator.pushNamed(contextDialog, PGParticipants.routeName,
            arguments: experiment.key);
      }));

  row.add(DatatableRows.getDownloadCell(() async {
    Excelfile _excelfile = new Excelfile();

    List list = await Database.getPgParticipants(experiment.key);
    List<PgParticipant> listParticipants = [];

    for (int i = 0; i < list.length; i++) {
      listParticipants.add(PgParticipant.fromJson(list[i]));
    }
    _excelfile.createSheet(listParticipants, experiment.key);
    // _excelfile.saveExcel();
    List<Excelfile> files = [];
    files = await _excelfile.getPgParticipantsFiles(experiment.key);
    files.add(_excelfile);
    Excelfile.downloadZip(files, experiment.key);
  }));

  row.add(DatatableRows.getDeactivate(
      experiment.active, experiment.key, experiment.adminId, () {
    experiment.active = !experiment.active;
    Database.changeStatusPG(experiment.active, experiment.key);
    // Navigator.pushReplacementNamed(
    //     contextDialog, PublicGoodsExperimentsPage.routeName);
    // Navigator.pop(contextDialog);
    // Navigator.pushNamed(contextDialog, PublicGoodsExperimentsPage.routeName);
  }, contextDialog));

  return row;
}
