import 'package:begapp_web/DatatableElements/Datatable.dart';
import 'package:begapp_web/DatatableElements/pagedTable.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemma_participant.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DilemmaParticipantsTable extends StatefulWidget {
  List participants;
  DilemmaParticipantsTable(this.participants);
  @override
  _DilemmaParticipantsTableState createState() =>
      _DilemmaParticipantsTableState();
}

class _DilemmaParticipantsTableState extends State<DilemmaParticipantsTable> {
  List<DilemmaParticipant> participantsAll = [];
  List<DilemmaParticipant> participants = [];
  int nParticipants = 6;
  int indexPage = 1;
  Alignment headerAlign = Alignment.center;
  Alignment rowsAlign = Alignment.center;
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  void initState() {
    participantsAll = widget.participants as List<DilemmaParticipant>;
    participants = participantsAll.sublist(
        0,
        nParticipants < participantsAll.length
            ? nParticipants
            : participantsAll.length);
    super.initState();
  }

  TextStyle _headerTextStyle = TextStyle(color: Colors.white, fontSize: 20);
  headerText(String s) {
    return Expanded(
        child: Container(
            //width: width*0.05,
            alignment: headerAlign,
            child: Tooltip(
                message: s,
                child: Text(
                  s,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: _headerTextStyle,
                  textAlign: TextAlign.center,
                ))));
  }

  cellText(String s) {
    return Container(
        alignment: rowsAlign, child: Text(s, textAlign: TextAlign.center));
  }

  cellTooltipText(String s) {
    return Container(
        width: width * 0.1,
        alignment: rowsAlign,
        child: Tooltip(
            message: s,
            child: Text(
              s,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )));
  }

  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return PagedTable(
      // search: null,
      table: EditableDatatable(
        allElements: participantsAll,
        elements: participants,
        headerTitles: [
          "#",
          AppLocalizations.of(context).translate('age'),
          AppLocalizations.of(context).translate('gender'),
          AppLocalizations.of(context).translate('occupation'),
          AppLocalizations.of(context).translate('cours'),
          AppLocalizations.of(context).translate('game'),
          // AppLocalizations.of(context).translate('results'),
          "download",
        ],
      ),
      previous: () {
        setState(() {
          if (indexPage > 1) indexPage--;

          participants = participantsAll.sublist(
              (nParticipants * (indexPage - 1) > 0)
                  ? (nParticipants * (indexPage - 1))
                  : 0,
              (nParticipants * indexPage) < participantsAll.length
                  ? (nParticipants * indexPage)
                  : participantsAll.length);
        });
      },
      next: () {
        setState(() {
          if ((nParticipants * indexPage) < participantsAll.length) indexPage++;
          participants = participantsAll.sublist(
              (nParticipants * (indexPage - 1)),
              (nParticipants * indexPage) < participantsAll.length
                  ? (nParticipants * indexPage)
                  : participantsAll.length);
        });
      },
    );
  }
}
