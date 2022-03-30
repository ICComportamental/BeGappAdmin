import 'package:begapp_web/DatatableElements/TableRows/datatableRows.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/classes/excel.dart';
import 'package:begapp_web/main.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemma_participant.dart';
import 'package:begapp_web/prisoner_dilemma/pages/DilemmaParticipants.page.dart';
import 'package:flutter/material.dart';

List<DataCell> getDilemmaExperiment(
    DilemmaVariables experiment, index, contextDialog, setstate) {
  List<DataCell> row = [];
  List<String> datas = [
    (index).toString(),
    experiment.gameName,
    experiment.key,
    experiment.adminId,
  ];
  datas.forEach((e) => row.add(DatatableRows.getCell(e)));

  row.add(DatatableRows.getEditCell(
      condition: experiment.adminId == localStorage.get('username'),
      edit: () async {
        await Dialogs.showEditDilemmaExperiment(contextDialog, experiment);
        setstate();
      }));

  row.add(DatatableRows.getSeeCell(
      condition: (experiment.adminId == localStorage.get('username') ||
          experiment.publicData ||
          localStorage.get('userType') == "master"),
      seeData: () {
        Navigator.pushNamed(contextDialog, DilemmaParticipantsPage.routeName,
            arguments: experiment.key);
      }));

  row.add(DatatableRows.getDownloadCell(() async {
    Excelfile _excelfile = new Excelfile();

    List list = await Database.getDilemmaParticipants(experiment.key);
    List<DilemmaParticipant> listParticipants = [];

    for (int i = 0; i < list.length; i++) {
      listParticipants.add(DilemmaParticipant.fromJson(list[i]));
    }
    _excelfile.createSheetDilemmaParticipants(listParticipants, experiment.key);

    List<Excelfile> files = [];
    files = await _excelfile.getPdParticipantsFiles(experiment.key);
    files.add(_excelfile);
    Excelfile.downloadZip(files, experiment.key);
  }));
  // print(row.length);
  row.forEach((element) {
    //print(element.child.runtimeType);
  });
  row.add(DatatableRows.getDeactivate(
      experiment.active, experiment.key, experiment.adminId, () {
    experiment.active = !experiment.active;
    Database.changeStatusPD(experiment.active, experiment.key);
    // Navigator.pushReplacementNamed(
    //     contextDialog, DilemmaExperimentsTablePage.routeName);
  }, contextDialog));
  return row;
}
