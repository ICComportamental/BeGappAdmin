import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaRound.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemma_participant.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/DilemmaDuration.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/DilemmaGameDataTable.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/graphic.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GameDataDilemma extends StatefulWidget {
  final DilemmaParticipant participant;
  final List<DilemmaRound> rounds;
  final int maxRounds;

  const GameDataDilemma(
      {Key? key,
      required this.participant,
      required this.rounds,
      required this.maxRounds})
      : super(key: key);

  @override
  _GameDataDilemmaState createState() => _GameDataDilemmaState();
}

class _GameDataDilemmaState extends State<GameDataDilemma> {
  List<FlSpot> defect = [];
  List<FlSpot> cooperate = [];
  TabController? _controller;

  getData() {
    double d = 0, c = 0;
    for (var i = 0; i < widget.rounds.length; i++) {
      if (widget.rounds[i].userChoice == 0)
        c++;
      else
        d++;
      defect.add(FlSpot((i++).toDouble(), d));
      cooperate.add(FlSpot((i++).toDouble(), c));
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      DilemmaDuration(widget.participant),
      DilemmaGameDataTable(widget.rounds),
      Graphic(
        maxRounds: widget.maxRounds,
        cooperate: cooperate,
        defect: defect,
      )
    ];
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            backgroundColor: Colors.white,
            leading: SizedBox(),
            bottom: TabBar(
              controller: _controller,
              tabs: [
                Text(
                  AppLocalizations.of(context).translate('duration'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.02),
                ),
                Text(
                  AppLocalizations.of(context).translate('rounds'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.02),
                ),
                Text(
                  AppLocalizations.of(context).translate('graphic'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.02),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: _pages,
          ),
        ));
  }
}
