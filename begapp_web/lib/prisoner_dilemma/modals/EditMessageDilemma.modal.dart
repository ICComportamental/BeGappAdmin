import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/classes/popup_message_pd.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/popUpMessagesDilemmaTable.dart';
import 'package:flutter/material.dart';

class EditMessageDilemmaModal extends StatefulWidget {
  final DilemmaVariables variables;

  const EditMessageDilemmaModal({Key? key, required this.variables})
      : super(key: key);
  @override
  _EditMessageDilemmaModalState createState() =>
      _EditMessageDilemmaModalState();
}

class _EditMessageDilemmaModalState extends State<EditMessageDilemmaModal> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Database.getPopUpMessagesDilemma(widget.variables.key),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List snap = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error fetching data: exp"),
          );
        }
        List<PopUpMessagePrisonersDilemma> messages = [];
        for (int index = 0; index < snap.length; index++) {
          messages.add(PopUpMessagePrisonersDilemma.fromJson(snap[index]));
        }

        return Center(
            child: Container(
          color: Colors.greenAccent,
          child: PopUpMessagesDilemmaTable(messages, widget.variables),
        ));
      },
    );
  }
}
