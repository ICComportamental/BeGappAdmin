import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/public_goods/classes/roundData.dart';

import 'package:begapp_web/widgets/customDatatable.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PGGameDataTable extends StatefulWidget {
  List roundsData;
  PGGameDataTable(this.roundsData);
  @override
  _PGGameDataTableState createState() => _PGGameDataTableState();
}

class _PGGameDataTableState extends State<PGGameDataTable> {
  List<RoundData> roundsAll = [];
  List<RoundData> rounds = [];
  int nExperiments = 8;
  int indexPage = 1;
  Alignment headerAlign = Alignment.center;
  Alignment rowsAlign = Alignment.center;
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  void initState() {
    roundsAll = widget.roundsData as List<RoundData>;
    rounds = roundsAll.sublist(
        0, nExperiments < roundsAll.length ? nExperiments : roundsAll.length);
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
  late ScrollController controller;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scrollbar(
      isAlwaysShown: true,
      child: ListView(children: [
        if (rounds.isEmpty)
          Center(
              child: Text(AppLocalizations.of(context).translate('noResults'),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.06))),
        Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CustomDataTable(
                  dataTable: DataTable(
                      headingRowHeight: 56, //*2.toDouble(),
                      dataRowHeight: kMinInteractiveDimension,
                      horizontalMargin: 24,
                      columnSpacing: 24,
                      columns: [
                        // DataColumn(label: Expanded(child:Container(alignment:headerAlign,child:Text(AppLocalizations.of(context).translate('sequence'),style: _headerTextStyle,textAlign: TextAlign.center,)))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('round'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('investiment'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('position'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('earning'))),
                        DataColumn(
                            label: headerText(
                                AppLocalizations.of(context).translate('rib'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('distribution'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('wallet'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('distribution'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('suspended'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('elections'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('votes'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('investing'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('distributing'))),
                        DataColumn(
                            label: headerText(AppLocalizations.of(context)
                                .translate('election'))),
                      ],
                      rows: rounds.map(
                        (round) {
                          double d = (round.earning / round.rib) * 100;
                          if (round.earning < 0) d = 0.0;
                          var f = new NumberFormat("###.0#", "en_US");
                          return DataRow(cells: [
                            DataCell(cellText(round.round.toString())),
                            DataCell(cellText(round.investment.toString())),
                            DataCell(cellText(round.positionToken.toString())),
                            DataCell(cellText(round.earning.toString())),
                            DataCell(cellText(round.rib.toString())),
                            DataCell(cellText(
                                round.distribution == 1 ? f.format(d) : "")),
                            DataCell(cellText(round.wallet.toString())),
                            DataCell(Container(
                                color: round.distribution == 1
                                    ? Colors.lightGreenAccent
                                    : Colors.transparent)),
                            DataCell(Container(
                                color: round.suspended == 1
                                    ? Colors.red
                                    : Colors.transparent)),
                            DataCell(cellText(round.electionCount.toString())),
                            DataCell(cellText(round.votes.toString())),
                            DataCell(cellText(format(round.dragToken))),
                            DataCell(cellText(format(round.distributionTime))),
                            DataCell(cellText(format(round.electionTime))),

                            // DataCell(
                            //   cellText(format(round.total))
                            // ),
                            // DataCell(
                            //   cellText(format(round.tutorial_main))
                            // ),
                            // DataCell(
                            //   cellText(format(round.tutorial_distribution))
                            // ),
                            // DataCell(
                            //   cellText(format(round.tutorial_election))
                            // ),
                            // DataCell(
                            //   cellText(round.saw_main_tutorial.toString())
                            // ),
                            // DataCell(
                            //   cellText(round.saw_distribution_tutorial.toString())
                            // ),
                            // DataCell(
                            //   cellText(round.saw_election_tutorial.toString())
                            // ),

                            // DataCell(
                            //   Center(child:Icon(Icons.gradient)),
                            //   onTap: () async{
                            //     Navigator.push(context,
                            //       MaterialPageRoute(
                            //         builder: (context)=> GameData(round: round,)
                            //       )
                            //     );
                            //   }
                            // ),
                            // DataCell(
                            //   Center(child:Icon(Icons.file_download)),
                            //   onTap: () async{
                            //     Excelfile _excelfile = new Excelfile(context);

                            //     List list = await Database.getPgroundData(round.user_id);
                            //     List<RoundData> roundsData= [];
                            //     // print(list);
                            //     for(int i=0;i<list.length;i++){
                            //       roundsData.add(RoundData.fromJson(list[i]));
                            //     }
                            //     _excelfile.createSheetPgData(roundsData);
                            //   }
                            // )
                          ]);
                        },
                      ).toList()),
                )) //headerColor: Colors.purple,
            ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 20,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  if (indexPage > 1) indexPage--;

                  rounds = roundsAll.sublist(
                      (nExperiments * (indexPage - 1) > 0)
                          ? (nExperiments * (indexPage - 1))
                          : 0,
                      (nExperiments * indexPage) < roundsAll.length
                          ? (nExperiments * indexPage)
                          : roundsAll.length);
                });
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 20,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_forward),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  if ((nExperiments * indexPage) < roundsAll.length)
                    indexPage++;
                  rounds = roundsAll.sublist(
                      (nExperiments * (indexPage - 1)),
                      (nExperiments * indexPage) < roundsAll.length
                          ? (nExperiments * indexPage)
                          : roundsAll.length);
                });
              },
            ),
          ),
        ])
      ]),
    );
  }
}
