import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/public_goods/classes/pgparticipant.dart';
import 'package:begapp_web/public_goods/widgets/PGParticpantsTable.dart';
import 'package:begapp_web/widgets/futureCheckLogin.dart';
import 'package:flutter/material.dart';

class PGParticipants extends StatefulWidget {
  static const routeName = '/Public_Goods_Experiment_Results';
  @override
  _PGParticipantsState createState() => _PGParticipantsState();
}

class _PGParticipantsState extends State<PGParticipants> {
  var experimentKey;
  @override
  Widget build(BuildContext context) {
    final experimentKey = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: FutureCheckLogin(
        page: FutureBuilder(
          future: Database.getPgParticipants(experimentKey.toString()),
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
            List<PgParticipant> participants = [];
            for (int index = 0; index < snap.length; index++) {
              participants.add(PgParticipant.fromJson(snap[index]));
            }
            return Center(
              child: PGParticipantsTable(participants),
            );
          },
        ),
      ),
    );
  }
}
