import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemma_participant.dart';
import 'package:flutter/material.dart';

class DilemmaDuration extends StatefulWidget {
  final DilemmaParticipant participant;
  DilemmaDuration(this.participant);
  @override
  _DilemmaDurationState createState() => _DilemmaDurationState();
}

class _DilemmaDurationState extends State<DilemmaDuration> {
  TextStyle _headerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );
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
        style: TextStyle(
          fontSize: 20,
        ),
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

  @override
  Widget build(BuildContext context) {
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
                setText(AppLocalizations.of(context).translate('timeTutorial')),
                setTextBody(format(widget.participant.tutorial)),
                setText(AppLocalizations.of(context).translate('sawTutorial')),
                setTextBody(widget.participant.sawTutorial.toString()),
              ])),
    );
  }
}
