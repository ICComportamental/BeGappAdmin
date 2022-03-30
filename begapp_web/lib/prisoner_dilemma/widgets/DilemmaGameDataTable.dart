import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaRound.dart';
import 'package:begapp_web/widgets/customDatatable.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// ignore: must_be_immutable
class DilemmaGameDataTable extends StatefulWidget {
  List roundsData;
  DilemmaGameDataTable(this.roundsData);
  @override
  _DilemmaGameDataTableState createState() => _DilemmaGameDataTableState();
}

class _DilemmaGameDataTableState extends State<DilemmaGameDataTable> {
  List<DilemmaRound> roundsAll = [];
  List<DilemmaRound> rounds = [];
  int nExperiments = 8;
  int indexPage = 1;
  Alignment headerAlign = Alignment.center;
  Alignment rowsAlign = Alignment.center;
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  void initState() {
    roundsAll = widget.roundsData as List<DilemmaRound>;
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
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
                          label: headerText(
                              AppLocalizations.of(context).translate('round'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('computer'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('choice'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('computerPoints'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('participantPoints'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('lostTime'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('sawOtherPoints'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('sawYourPoints'))),
                      DataColumn(
                          label: headerText(AppLocalizations.of(context)
                              .translate('dragCard'))),
                    ],
                    rows: rounds.map(
                      (round) {
                        return DataRow(cells: [
                          DataCell(cellText(round.round.toString())),
                          DataCell(cellText(round.computer.toString())),
                          DataCell(cellText(round.userChoice.toString())),
                          DataCell(cellText(round.otherPoints.toString())),
                          DataCell(cellText(round.userPoints.toString())),
                          DataCell(Container(
                              color: round.lostRound == 1
                                  ? Colors.red
                                  : Colors.transparent)),
                          DataCell(cellText(round.sawOtherPoints.toString())),
                          DataCell(cellText(round.sawYourPoints.toString())),
                          // DataCell(
                          //   Container(color:round.distribution==1?Colors.lightGreenAccent:Colors.transparent)
                          // ),
                          DataCell(cellText(format(round.dragCard))),

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
                          //     List<RoundData> roundsData= new List();
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
                if ((nExperiments * indexPage) < roundsAll.length) indexPage++;
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
    ]);
  }
}
