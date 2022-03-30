import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/public_goods/classes/pgparticipant.dart';
import 'package:begapp_web/public_goods/classes/roundData.dart';
import 'package:flutter/material.dart';

import 'classes/excel.dart';

class ExcelPage extends StatefulWidget {
  @override
  _ExcelPageState createState() => _ExcelPageState();
}

class _ExcelPageState extends State<ExcelPage> {
  void makeExcel(context) async {
    Excelfile _excelfile = new Excelfile();

    List list = await Database.getPgParticipants("pg2a");
    List<PgParticipant> participants = [];
    // print(list);
    setState(() {
      for (int i = 0; i < list.length; i++) {
        participants.add(PgParticipant.fromJson(list[i]));
      }
    });

    _excelfile.createSheet(participants, "pg2a");

    setState(() {});
  }

  exportPgData(context) async {
    Excelfile _excelfile = new Excelfile();

    List list = await Database.getPgParticipantData(184);
    List<RoundData> roundsData = [];
    // print(list);
    for (int i = 0; i < list.length; i++) {
      roundsData.add(RoundData.fromJson(list[i]));
    }
    _excelfile.createSheetPgData(roundsData);

    setState(() {});
  }

  String txt = "Baixar";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextButton(onPressed: () => makeExcel(context), child: Text(txt)),
      TextButton(
          onPressed: () => exportPgData(context), child: Text("data pg")),
    ]);
  }
}
