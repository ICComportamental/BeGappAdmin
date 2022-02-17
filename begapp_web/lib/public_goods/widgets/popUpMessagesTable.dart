import 'package:begapp_web/DatatableElements/Datatable.dart';
import 'package:begapp_web/DatatableElements/pagedTable.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/popup_message_pg.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/modals/CreateMessage.dart';
import 'package:begapp_web/public_goods/modals/EditMessage.modal.dart';
import 'package:flutter/material.dart';

class PopUpMessagesTable extends StatefulWidget {
  final List<PopUpMessagePublicGoods> messages;
  final PublicGoodsVariables variables;
  PopUpMessagesTable(this.messages, this.variables);
  @override
  _PopUpMessagesTableState createState() => _PopUpMessagesTableState();
}

class _PopUpMessagesTableState extends State<PopUpMessagesTable> {
  List<PopUpMessagePublicGoods> messagesAll = [];
  List<PopUpMessagePublicGoods> messages = [];
  int nMessages = 50;
  int indexPage = 1;

  @override
  void initState() {
    messagesAll = widget.messages;
    messages = messagesAll.sublist(
        0, nMessages < messagesAll.length ? nMessages : messagesAll.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: BackButton(color: Colors.black),
      // ),
      body: Stack(
        children: [
          PagedTable(
            // search: (String txtSearch) async {
            //   List list = await Database.searchPGExperiments("key", txtSearch);
            //   //print(list);
            //   setState(() {
            //     indexPage = 1;
            //     messagesAll = [];
            //     for (int i = 0; i < list.length; i++) {
            //       messagesAll.add(PublicGoodsVariables.fromJson(list[i]));
            //     }
            //   });
            //   experiments = messagesAll.sublist(
            //       0,
            //       nMessages < messagesAll.length
            //           ? nMessages
            //           : messagesAll.length);
            // },
            appbar: false,
            // confirmBtn: true,
            table: EditableDatatable(
              allElements: messagesAll,
              elements: messages,
              headerTitles: [
                "#",
                AppLocalizations.of(context).translate('message'),
                AppLocalizations.of(context).translate('experiment'),
                AppLocalizations.of(context).translate('round'),
                AppLocalizations.of(context).translate('level'),
                AppLocalizations.of(context).translate('edit'),
                "Delete"
              ],
            ),
            previous: () {
              setState(() {
                if (indexPage > 1) indexPage--;

                messages = messagesAll.sublist(
                    (nMessages * (indexPage - 1) > 0)
                        ? (nMessages * (indexPage - 1))
                        : 0,
                    (nMessages * indexPage) < messagesAll.length
                        ? (nMessages * indexPage)
                        : messagesAll.length);
              });
            },
            next: () {
              setState(() {
                if ((nMessages * indexPage) < messagesAll.length) indexPage++;
                messages = messagesAll.sublist(
                    (nMessages * (indexPage - 1)),
                    (nMessages * indexPage) < messagesAll.length
                        ? (nMessages * indexPage)
                        : messagesAll.length);
              });
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: FloatingActionButton(
                  tooltip: AppLocalizations.of(context).translate('return'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: FloatingActionButton(
                  tooltip: AppLocalizations.of(context).translate('add'),
                  onPressed: () {
                    Dialog createMessage = Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CreateMessage(widget.variables.maxTrys,
                            (PopUpMessagePublicGoods message) async {
                          String query =
                              """ INSERT INTO `popup_message_pg`(`message`, `experiment`, `round`, `level`, `criterion`) VALUES (
                        '${message.message}','${widget.variables.key}',${message.round},${message.level},${message.criterion});
                     """;
                          await Database.insert(query);
                          Navigator.pop(
                              context); //força o refresh da tabela de mensagens
                          Dialog dialog = Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: EditMessageModal(
                                variables: widget.variables,
                              ));

                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialog);
                        }));

                    showDialog(
                        context: context,
                        builder: (BuildContext context) => createMessage);
                  },
                  child: Icon(
                    Icons.add,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
