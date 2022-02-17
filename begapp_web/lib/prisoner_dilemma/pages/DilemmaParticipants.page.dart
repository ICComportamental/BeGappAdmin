import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemma_participant.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/DilemmaParticpantsTable.dart';
import 'package:begapp_web/widgets/futureCheckLogin.dart';
import 'package:flutter/material.dart';

class DilemmaParticipantsPage extends StatefulWidget {
  static const routeName = '/Prisoners_Dilemma_Experiment_Results';
  //final experimentKey;
  DilemmaParticipantsPage();
  @override
  _DilemmaParticipantsPageState createState() =>
      _DilemmaParticipantsPageState();
}

class _DilemmaParticipantsPageState extends State<DilemmaParticipantsPage> {
  @override
  Widget build(BuildContext context) {
    final experimentKey = ModalRoute.of(context)!.settings.arguments;
    return FutureCheckLogin(
      page: Scaffold(
        body: FutureBuilder(
          future: Database.getDilemmaParticipants(experimentKey.toString()),
          builder: (context, snapshot) {
            //  print(snap[1]);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error fetching data"),
              );
            }
            List snap = snapshot.data as List<dynamic>;
            List<DilemmaParticipant> participants = [];
            for (int index = 0; index < snap.length; index++) {
              participants.add(DilemmaParticipant.fromJson(snap[index]));
            }
            return Center(
              child: DilemmaParticipantsTable(participants),
            );
          },
        ),
      ),
    );
  }
}
