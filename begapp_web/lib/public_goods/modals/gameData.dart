import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/public_goods/classes/pgparticipant.dart';
import 'package:begapp_web/public_goods/classes/roundData.dart';
import 'package:begapp_web/public_goods/widgets/PGGameDataTable.dart';
import 'package:begapp_web/public_goods/widgets/pg_duration.dart';
import 'package:flutter/material.dart';

class GameData extends StatefulWidget {
  final PgParticipant participant;
  final List<RoundData> rounds;

  const GameData({Key? key, required this.participant, required this.rounds})
      : super(key: key);

  @override
  _GameDataState createState() => _GameDataState();
}

class _GameDataState extends State<GameData> {
  TabController? _controller;
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      PGDuration(widget.participant),
      PGGameDataTable(widget.rounds)
    ];
    double size = MediaQuery.of(context).size.width * 0.017;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: SizedBox(),
            bottom: TabBar(
              controller: _controller,
              tabs: [
                Text(
                  AppLocalizations.of(context).translate('rounds'),
                  style: TextStyle(color: Colors.black, fontSize: size),
                ),
                Text(
                  AppLocalizations.of(context).translate('duration'),
                  style: TextStyle(color: Colors.black, fontSize: size),
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
