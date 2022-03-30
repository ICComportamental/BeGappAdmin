import 'package:begapp_web/DatatableElements/Datatable.dart';
import 'package:begapp_web/DatatableElements/pagedTable.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/public_goods/classes/pgparticipant.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// ignore: must_be_immutable
class PGParticipantsTable extends StatefulWidget {
  List experiments;
  PGParticipantsTable(this.experiments);
  @override
  _PGParticipantsTableState createState() => _PGParticipantsTableState();
}

class _PGParticipantsTableState extends State<PGParticipantsTable> {
  List<PgParticipant> participantsAll = [];
  List<PgParticipant> participants = [];
  int nExperiments = 6;
  int indexPage = 1;
  Alignment headerAlign = Alignment.center;
  Alignment rowsAlign = Alignment.center;
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  void initState() {
    participantsAll = widget.experiments as List<PgParticipant>;
    participants = participantsAll.sublist(
        0,
        nExperiments < participantsAll.length
            ? nExperiments
            : participantsAll.length);
    super.initState();
  }

  function() {
    setState(() {});
  }

  TextEditingController txtSearch = new TextEditingController();

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

    if (true)
      return PagedTable(
        search: null,
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
            "download",
          ],
        ),
        previous: () {
          setState(() {
            if (indexPage > 1) indexPage--;

            participants = participantsAll.sublist(
                (nExperiments * (indexPage - 1) > 0)
                    ? (nExperiments * (indexPage - 1))
                    : 0,
                (nExperiments * indexPage) < participantsAll.length
                    ? (nExperiments * indexPage)
                    : participantsAll.length);
          });
        },
        next: () {
          setState(() {
            if ((nExperiments * indexPage) < participantsAll.length)
              indexPage++;
            participants = participantsAll.sublist(
                (nExperiments * (indexPage - 1)),
                (nExperiments * indexPage) < participantsAll.length
                    ? (nExperiments * indexPage)
                    : participantsAll.length);
          });
        },
      );
  }
}
