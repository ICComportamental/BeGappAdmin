import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/popup_message_pg.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/widgets/popUpMessagesTable.dart';
import 'package:flutter/material.dart';

class EditMessageModal extends StatefulWidget {
  final PublicGoodsVariables variables;

  const EditMessageModal({Key? key, required this.variables}) : super(key: key);
  @override
  _EditMessageModalState createState() => _EditMessageModalState();
}

class _EditMessageModalState extends State<EditMessageModal> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Database.getPopUpMessages(widget.variables.key),
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
        List<PopUpMessagePublicGoods> messages = [];
        for (int index = 0; index < snap.length; index++) {
          messages.add(PopUpMessagePublicGoods.fromJson(snap[index]));
        }

        return Center(
            child: Container(
          color: Colors.greenAccent,
          child: PopUpMessagesTable(messages, widget.variables),
        ));
      },
    );
  }
}
