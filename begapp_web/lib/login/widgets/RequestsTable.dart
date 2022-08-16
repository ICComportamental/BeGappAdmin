import 'package:begapp_web/DatatableElements/Datatable.dart';
import 'package:begapp_web/DatatableElements/classes/search.dart';
import 'package:begapp_web/DatatableElements/pagedTable.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/login/classes/requestUserAdmin.dart';
import 'package:flutter/material.dart';

class RequestsTable extends StatefulWidget {
  final List<AdminUserRequest> requests;

  const RequestsTable({Key? key, required this.requests}) : super(key: key);

  @override
  _RequestsTableState createState() => _RequestsTableState();
}

class _RequestsTableState extends State<RequestsTable> {
  List<AdminUserRequest> requests = [];
  List<AdminUserRequest> pageRequests = [];
  int nRequests = 5;
  int indexPage = 1;
  @override
  void initState() {
    requests = widget.requests;
    pageRequests = requests.sublist(
        0, nRequests < requests.length ? nRequests : requests.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedTable(
      search: new Search([
        AppLocalizations.of(context).translate('name'),
        AppLocalizations.of(context).translate('email'),
      ], [
        "name",
        "email",
      ], (String column, String txtSearch) async {
        List list =
            await Database.search("admin_user_request", column, txtSearch);
        setState(() {
          indexPage = 1;
          requests = [];
          for (int i = 0; i < list.length; i++) {
            requests.add(AdminUserRequest.fromJson(list[i]));
          }
          pageRequests = requests.sublist(
              0, nRequests < requests.length ? nRequests : requests.length);
        });
      }),
      table: EditableDatatable(
        allElements: requests,
        elements: pageRequests,
        headerTitles: [
          "#",
          AppLocalizations.of(context).translate('name'),
          AppLocalizations.of(context).translate('email'),
          AppLocalizations.of(context).translate('intention'),
          AppLocalizations.of(context).translate('details'),
          AppLocalizations.of(context).translate('approve'),
          AppLocalizations.of(context).translate('Deny'),
        ],
      ),
      previous: () {
        setState(() {
          if (indexPage > 1) indexPage--;

          pageRequests = requests.sublist(
              (nRequests * (indexPage - 1) > 0)
                  ? (nRequests * (indexPage - 1))
                  : 0,
              (nRequests * indexPage) < requests.length
                  ? (nRequests * indexPage)
                  : requests.length);
        });
      },
      next: () {
        setState(() {
          if ((nRequests * indexPage) < requests.length) indexPage++;
          pageRequests = requests.sublist(
              (nRequests * (indexPage - 1)),
              (nRequests * indexPage) < requests.length
                  ? (nRequests * indexPage)
                  : requests.length);
        });
      },
    );

    // item(String title, String info) {
    //   return Container(
    //       alignment: Alignment.centerLeft,
    //       padding: EdgeInsets.all(10),
    //       margin: EdgeInsets.only(
    //           bottom: 10, left: width * 0.1, right: width * 0.1),
    //       width: width * 0.5,
    //       height: height * 0.15,
    //       decoration: BoxDecoration(
    //           border: Border.all(color: Colors.black),
    //           borderRadius: BorderRadius.circular(5)),
    //       child: Text(
    //         title + ": " + info,
    //         textAlign: TextAlign.center,
    //       ));
    // }

    // return Scaffold(
    //     body: Scrollbar(
    //   isAlwaysShown: true,
    //   child: ListView(
    //     children: (widget.requests.isEmpty)
    //         ? [
    //             CustomAppBar(),
    //             space(),
    //             Center(
    //                 child: Text(
    //                     AppLocalizations.of(context).translate('noResults'),
    //                     style: TextStyle(
    //                         color: Colors.grey,
    //                         fontSize:
    //                             MediaQuery.of(context).size.width * 0.06)))
    //           ]
    //         : [
    //             CustomAppBar(),
    //             space(),
    //             item("NOME", widget.requests[index].name),
    //             item("EMAIL", widget.requests[index].email),
    //             item("MOTIVAÇÃO", widget.requests[index].intention),
    //             Container(
    //                 margin: EdgeInsets.symmetric(horizontal: width * 0.4),
    //                 height: height * 0.12,
    //                 decoration: BoxDecoration(
    //                   color: Colors.blue,
    //                   borderRadius: BorderRadius.all(Radius.circular(5)),
    //                 ),
    //                 child: TextButton(
    //                     onPressed: () async {
    //                       await Database.update(
    //                           "UPDATE  `admin_user_request` SET `approved`=true WHERE id=" +
    //                               widget.requests[index].id.toString());
    //                       //Envia o email para que o cadastro do novo adm seja concluido
    //                       Database.sendEmail(
    //                           widget.requests[index].email,
    //                           "Cadastro BeGapp",
    //                           "Sua solicitação de cadastro foi aprovada, clique no link para prosseguir com o cadastro: " +
    //                               "https://v1.begapp.com.brAdmin/#/RegisterPage");
    //                       Navigator.pushReplacementNamed(
    //                           context, RequestsPage.routeName);
    //                     },
    //                     child: Text(
    //                         AppLocalizations.of(context).translate('approve'),
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: height * 0.04)))),
    //             space(),
    //             PagedTableButtons(
    //               next: () {
    //                 setState(() {
    //                   if (index < widget.requests.length - 1) index++;
    //                 });
    //               },
    //               previous: () {
    //                 setState(() {
    //                   if (index > 0) index--;
    //                 });
    //               },
    //             )
    //           ],
    //   ),
    // ));
  }
}
