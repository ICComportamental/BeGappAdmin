import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:begapp_web/prisoner_dilemma/widgets/dilemmaExperimentsTable.dart';
import 'package:begapp_web/widgets/futureCheckLogin.dart';
import 'package:flutter/material.dart';

class DilemmaExperimentsTablePage extends StatefulWidget {
  static const routeName = '/Prisoners_Dilemma_Experiments';
  DilemmaExperimentsTablePage();
  @override
  _DilemmaExperimentsTablePageState createState() =>
      _DilemmaExperimentsTablePageState();
}

class _DilemmaExperimentsTablePageState
    extends State<DilemmaExperimentsTablePage> {
  // refresh()async{
  //   List list = await Database.getDilemmaExperiments();
  //   print(list);
  //   setState(() {
  //   experiments= new List();
  //   for(int i=0;i<list.length;i++){
  //     experiments.add(DilemmaVariables.fromJson(list[i]));
  //   }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return FutureCheckLogin(
      page: Scaffold(
        body: FutureBuilder(
          future: Database.getDilemmaExperiments(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text("Error fetching data:" +
                          snapshot.error
                              .toString() /*+
                      snap.toString()*/
                      ));
            }
            List snap = snapshot.data as List<dynamic>;

            List<DilemmaVariables> experiments = [];
            for (int index = 0; index < snap.length; index++) {
              experiments.add(DilemmaVariables.fromJson(snap[index]));
            }
            return Center(
              child: DilemmaExperimentsTable(
                experiments,
              ),
            );
          },
        ),
      ),
    );
  }
}
