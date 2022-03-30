import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/public_goods/classes/pgparticipant.dart';

import 'package:flutter/material.dart';

class PGDuration extends StatefulWidget {
  final PgParticipant participant;
  PGDuration(this.participant);
  @override
  _PGDurationState createState() => _PGDurationState();
}

class _PGDurationState extends State<PGDuration> {
  late TextStyle _headerTextStyle;
  late TextStyle _style;
  double stroke = 2.0;
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  setText(String s,
      {bool r: false, bool l: true, bool t: false, bool b: true}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(
        s,
        style: _headerTextStyle,
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
          color: Colors.indigoAccent,
          border: Border(
            right: r
                ? BorderSide(
                    color: Colors.black,
                    width: stroke,
                  )
                : BorderSide.none,
            left: l
                ? BorderSide(
                    color: Colors.black,
                    width: stroke,
                  )
                : BorderSide.none,
            top: t
                ? BorderSide(
                    color: Colors.black,
                    width: stroke,
                  )
                : BorderSide.none,
            bottom: b
                ? BorderSide(
                    color: Colors.black,
                    width: stroke,
                  )
                : BorderSide.none,
          )),
    );
  }

  setTextBody(String s,
      {bool r: true, bool l: true, bool t: false, bool b: true}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(
        s,
        style: _style,
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
          // color: Colors.indigoAccent,
          border: Border(
        right: r
            ? BorderSide(
                color: Colors.black,
                width: stroke,
              )
            : BorderSide.none,
        left: l
            ? BorderSide(
                color: Colors.black,
                width: stroke,
              )
            : BorderSide.none,
        top: t
            ? BorderSide(
                color: Colors.black,
                width: stroke,
              )
            : BorderSide.none,
        bottom: b
            ? BorderSide(
                color: Colors.black,
                width: stroke,
              )
            : BorderSide.none,
      )),
    );
  }

  double size = 0;
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.016;
    _headerTextStyle = TextStyle(
      color: Colors.white,
      fontSize: size,
    );
    _style = TextStyle(
      fontSize: size,
    );
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0.0,
              crossAxisCount: 2,
              childAspectRatio: 10,
              scrollDirection: Axis.vertical,
              children: [
                setText(AppLocalizations.of(context).translate('total'),
                    t: true),
                setTextBody(format(widget.participant.total), t: true),
                setText(AppLocalizations.of(context).translate('mainTutorial')),
                setTextBody(format(widget.participant.tutorialMain)),
                setText(AppLocalizations.of(context)
                    .translate('distributionTutorial')),
                setTextBody(format(widget.participant.tutorialMain)),
                setText(
                    AppLocalizations.of(context).translate('electionTutorial')),
                setTextBody(format(widget.participant.tutorialElection)),
                setText(AppLocalizations.of(context).translate('mainTutorial')),
                setTextBody(widget.participant.sawMainTutorial.toString()),
                setText(AppLocalizations.of(context)
                    .translate('distributionTutorial')),
                setTextBody(
                    widget.participant.sawDistributionTutorial.toString()),
                setText(
                    AppLocalizations.of(context).translate('electionTutorial')),
                setTextBody(
                    widget.participant.sawDistributionTutorial.toString()),
              ])),
    );
  }
}
