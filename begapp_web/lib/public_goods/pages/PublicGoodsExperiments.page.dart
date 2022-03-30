import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/widgets/publicGoodsExperimentsTable.dart';
import 'package:begapp_web/widgets/futureCheckLogin.dart';
import 'package:flutter/material.dart';

class PublicGoodsExperimentsPage extends StatefulWidget {
  static const routeName = '/Public_Goods_Experiments';
  @override
  _PublicGoodsExperimentsPageState createState() =>
      _PublicGoodsExperimentsPageState();
}

class _PublicGoodsExperimentsPageState
    extends State<PublicGoodsExperimentsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureCheckLogin(
      page: Scaffold(
        body: FutureBuilder(
          future: Database.getPublicGoodsExperiments(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
            List snap = snapshot.data as List<dynamic>;
            List<PublicGoodsVariables> experiments = [];
            for (int index = 0; index < snap.length; index++) {
              experiments.add(PublicGoodsVariables.fromJson(snap[index]));
            }

            return Center(
                child: Container(
              child: PublicGoodsExperimentsTable(experiments),
            ));
          },
        ),
      ),
    );
  }
}
