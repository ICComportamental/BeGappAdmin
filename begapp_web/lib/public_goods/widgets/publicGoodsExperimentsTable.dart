import 'package:begapp_web/DatatableElements/classes/search.dart';
import 'package:begapp_web/DatatableElements/pagedTable.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/classes/excel.dart';
import 'package:begapp_web/main.dart';
import 'package:begapp_web/public_goods/classes/PG_variables.dart';
import 'package:begapp_web/public_goods/classes/pgparticipant.dart';
import 'package:begapp_web/public_goods/pages/PGParticipants.dart';
import 'package:begapp_web/DatatableElements/Datatable.dart';
import 'package:begapp_web/widgets/app_bar.dart';
import 'package:begapp_web/DatatableElements/btnPagedTable.dart';
import 'package:begapp_web/widgets/customDatatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PublicGoodsExperimentsTable extends StatefulWidget {
  List<PublicGoodsVariables> experiments;
  PublicGoodsExperimentsTable(this.experiments);
  @override
  _PublicGoodsExperimentsTableState createState() =>
      _PublicGoodsExperimentsTableState();
}

class _PublicGoodsExperimentsTableState
    extends State<PublicGoodsExperimentsTable> {
  List<PublicGoodsVariables> experimentsAll = [];
  List<PublicGoodsVariables> experiments = [];
  int nExperiments = 8;
  int indexPage = 1;
  Alignment headerAlign = Alignment.center;
  Alignment rowsAlign = Alignment.center;
  DateFormat f = new DateFormat("dd/MM/yyyy");
  // String hugetxt = "dfilukfndskjnmdlskfger wfnlfflçsflsffshfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffdjjsjidjskljslfksjfslfsflsfjfjlsjlfjlsjflsjfsljfl slfsnfçs fsfsflsfksmfslkfmsfslfmsçfmsçfsmfçsmfsçfmgusnfvlsfmvslfmslfmsflsfmmlkdm";
  String hugetxt =
      "Now let’s create a Dialog BoxContainer with an image inside it. Remember we have already added that image in our pubspec.yaml file";
  @override
  void initState() {
    experimentsAll = widget.experiments;
    experiments = experimentsAll.sublist(
        0,
        nExperiments < experimentsAll.length
            ? nExperiments
            : experimentsAll.length);
    super.initState();
  }

  function() {
    setState(() {});
  }

  TextEditingController txtSearch = new TextEditingController();

  int searchFlex = 1;
  int tableFlex = 4;
  int btnFlex = 1;

  @override
  Widget build(BuildContext context) {
    TextStyle _headerTextStyle = TextStyle(color: Colors.white, fontSize: 20);
    hugetxt =
        "kkkfndvniofowsfjopwsfcnsdlkfmsdklmcflksdvnsdkklfsgjfnvsdiojfsdlfjsdlf iosjflskfnslfksmflk";
    space() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      );
    }

    //print("type:" + localStorage.get('userType'));
    if (true)
      return PagedTable(
        search: new Search([
          AppLocalizations.of(context).translate('name'),
          AppLocalizations.of(context).translate('key'),
          AppLocalizations.of(context).translate('creator'),
        ], [
          "name",
          "key",
          "adminId"
        ], (String column, String txtSearch, bool active) async {
          List list =
              await Database.searchPGExperiments(column, txtSearch, active);
          //print(list);
          setState(() {
            indexPage = 1;
            experimentsAll = [];
            for (int i = 0; i < list.length; i++) {
              experimentsAll.add(PublicGoodsVariables.fromJson(list[i]));
            }
          });
          experiments = experimentsAll.sublist(
              0,
              nExperiments < experimentsAll.length
                  ? nExperiments
                  : experimentsAll.length);
        }, suportArchive: true),
        table: EditableDatatable(
          allElements: experimentsAll,
          elements: experiments,
          headerTitles: [
            "#",
            AppLocalizations.of(context).translate('name'),
            AppLocalizations.of(context).translate('key'),
            AppLocalizations.of(context).translate('creator'),
            AppLocalizations.of(context).translate('desc'),
            AppLocalizations.of(context).translate('edit'),
            AppLocalizations.of(context).translate('results'),
            "download",
            "Status",
          ],
        ),
        previous: () {
          setState(() {
            if (indexPage > 1) indexPage--;

            experiments = experimentsAll.sublist(
                (nExperiments * (indexPage - 1) > 0)
                    ? (nExperiments * (indexPage - 1))
                    : 0,
                (nExperiments * indexPage) < experimentsAll.length
                    ? (nExperiments * indexPage)
                    : experimentsAll.length);
          });
        },
        next: () {
          setState(() {
            if ((nExperiments * indexPage) < experimentsAll.length) indexPage++;
            experiments = experimentsAll.sublist(
                (nExperiments * (indexPage - 1)),
                (nExperiments * indexPage) < experimentsAll.length
                    ? (nExperiments * indexPage)
                    : experimentsAll.length);
          });
        },
      );
    else
      return Scrollbar(
        isAlwaysShown: true,
        child: ListView(children: [
          CustomAppBar(),
          space(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            child: TextFormField(
              controller: txtSearch,
              decoration: InputDecoration(
                  // labelText://AppLocalizations.of(context).translate('experimentName'),
                  // filled: true,
                  // fillColor: Colors.white,
                  labelStyle: TextStyle(
                      // fontSize: labelSize
                      ),
                  suffixIcon: TextButton(
                    child: Icon(Icons.search),
                    onPressed: () async {
                      List list = await Database.searchPGExperiments(
                          "name", txtSearch.text, false);
                      //print(list);
                      setState(() {
                        indexPage = 1;
                        experimentsAll = [];
                        for (int i = 0; i < list.length; i++) {
                          experimentsAll
                              .add(PublicGoodsVariables.fromJson(list[i]));
                        }
                      });
                      experiments = experimentsAll.sublist(
                          0,
                          nExperiments < experimentsAll.length
                              ? nExperiments
                              : experimentsAll.length);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)
                      .translate('Required field');
                }
                return null;
              },
            ),
          ),
          space(),
          EditableDatatable(
            allElements: experimentsAll,
            elements: experiments,
            headerTitles: [
              "#",
              AppLocalizations.of(context).translate('name'),
              AppLocalizations.of(context).translate('key'),
              AppLocalizations.of(context).translate('creator'),
              AppLocalizations.of(context).translate('desc'),
              AppLocalizations.of(context).translate('edit'),
              AppLocalizations.of(context).translate('results'),
              "download",
            ],
          ),
          if (experiments.isEmpty)
            Center(
                child: Text(AppLocalizations.of(context).translate('noResults'),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 0.06))),
          Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CustomDataTable(
                  dataTable: DataTable(
                      headingRowHeight: 56,
                      dataRowHeight: kMinInteractiveDimension,
                      horizontalMargin: 24,
                      columnSpacing: 24,
                      columns: [
                        DataColumn(
                            label: Expanded(
                                child: Container(
                                    alignment: headerAlign,
                                    child: Text(
                                      "#",
                                      style: _headerTextStyle,
                                      textAlign: TextAlign.center,
                                    )))),
                        DataColumn(
                            label: Expanded(
                                child: Container(
                                    alignment: headerAlign,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('name'),
                                      style: _headerTextStyle,
                                      textAlign: TextAlign.center,
                                    )))),
                        DataColumn(
                            label: Expanded(
                                child: Container(
                                    alignment: headerAlign,
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('key'),
                                        style: _headerTextStyle,
                                        textAlign: TextAlign.center)))),
                        DataColumn(
                            label: Expanded(
                                child: Container(
                                    alignment: headerAlign,
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('creator'),
                                        style: _headerTextStyle,
                                        textAlign: TextAlign.center)))),
                        DataColumn(
                            label: Expanded(
                                child: Container(
                                    alignment: headerAlign,
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('desc'),
                                        style: _headerTextStyle,
                                        textAlign: TextAlign.center)))),
                        DataColumn(
                            label: Expanded(
                          child: Container(
                            alignment: headerAlign,
                            child: Text(
                                AppLocalizations.of(context).translate('edit'),
                                style: _headerTextStyle),
                          ),
                        )),
                        DataColumn(
                            label: Expanded(
                                child: Container(
                          alignment: headerAlign,
                          child: Text(
                              AppLocalizations.of(context).translate('results'),
                              style: _headerTextStyle,
                              textAlign: TextAlign.center),
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Container(
                          alignment: headerAlign,
                          child: Text("download",
                              style: _headerTextStyle,
                              textAlign: TextAlign.center),
                        )))
                      ],
                      rows: experiments.map(
                        (experiment) {
                          String g =
                              experiment.key.toLowerCase().substring(0, 2);

                          return DataRow(cells: [
                            DataCell(
                              Container(
                                  alignment: rowsAlign,
                                  child: Text(
                                      (experimentsAll.indexOf(experiment) + 1)
                                          .toString(),
                                      textAlign: TextAlign.center)),
                            ),
                            DataCell(
                              Container(
                                  alignment: rowsAlign,
                                  child: Text(experiment.name,
                                      textAlign: TextAlign.center)),
                              onTap: () async {
                                // experiment =
                                // await Dialogs.showEditingDialog(context,'name', experiment.name,experiment,function);
                              },
                            ),
                            DataCell(
                                Container(
                                  alignment: rowsAlign,
                                  child: Text(experiment.key),
                                  // decoration: BoxDecoration(
                                  //   border: Border.symmetric(vertical:BorderSide(color: Colors.black),)
                                  // ),
                                ), onTap: () {
                              Dialogs.showSimpleCustomDialog(context);
                            }),
                            DataCell(
                                Container(
                                  alignment: rowsAlign,
                                  child: Text(experiment.adminId),
                                ),
                                onTap: () {}),
                            DataCell(
                              Container(
                                width: kMinInteractiveDimension * 2,
                                height: kMinInteractiveDimension,
                                // color:Colors.red,
                                child: Text(
                                  experiment.descri,
                                  // hugetxt,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              onTap: () async {},
                            ),
                            DataCell(
                                Center(
                                    child: Icon(
                                  Icons.edit,
                                  color: experiment.adminId ==
                                          localStorage.get('username')
                                      ? Colors.green
                                      : Colors.red,
                                )),
                                onTap: experiment.adminId ==
                                        localStorage.get('username')
                                    ? () async {
                                        await Dialogs
                                            .showEditPublicGoodsExperiment(
                                                context, experiment);
                                        setState(() {});
                                      }
                                    : null),
                            DataCell(
                                Center(
                                    //so deixa ver os resultados se o experimento for do admin ou forem publicos
                                    child: Icon(
                                  Icons.gradient,
                                  color: (experiment.adminId ==
                                              localStorage.get('username') ||
                                          experiment.publicData ||
                                          localStorage.get('userType') ==
                                              "master")
                                      ? Colors.green
                                      : Colors.red,
                                )),
                                onTap: (experiment.adminId ==
                                            localStorage.get('username') ||
                                        experiment.publicData)
                                    ? () async {
                                        Navigator.pushNamed(
                                            context, PGParticipants.routeName,
                                            arguments: experiment.key);
                                      }
                                    : null),
                            DataCell(Center(child: Icon(Icons.file_download)),
                                onTap: () async {
                              Excelfile _excelfile = new Excelfile();

                              List list = await Database.getPgParticipants(
                                  experiment.key);
                              List<PgParticipant> listParticipants = [];
                              // //print(list);
                              for (int i = 0; i < list.length; i++) {
                                listParticipants
                                    .add(PgParticipant.fromJson(list[i]));
                              }
                              _excelfile.createSheet(
                                  listParticipants, experiment.key);
                            })
                          ]);
                        },
                      ).toList()),
                ),
              ) //headerColor: Colors.purple,
              ),
          space(),
          PagedTableButtons(
            previous: () {
              setState(() {
                if (indexPage > 1) indexPage--;

                experiments = experimentsAll.sublist(
                    (nExperiments * (indexPage - 1) > 0)
                        ? (nExperiments * (indexPage - 1))
                        : 0,
                    (nExperiments * indexPage) < experimentsAll.length
                        ? (nExperiments * indexPage)
                        : experimentsAll.length);
              });
            },
            next: () {
              setState(() {
                if ((nExperiments * indexPage) < experimentsAll.length)
                  indexPage++;
                experiments = experimentsAll.sublist(
                    (nExperiments * (indexPage - 1)),
                    (nExperiments * indexPage) < experimentsAll.length
                        ? (nExperiments * indexPage)
                        : experimentsAll.length);
              });
            },
          )
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   CircleAvatar(
          //     backgroundColor: Colors.blue,
          //     radius: 20,
          //     child: IconButton(
          //       padding: EdgeInsets.zero,
          //       icon: Icon(Icons.arrow_back),
          //       color: Colors.white,
          //       onPressed: () {
          //         setState(() {
          //           if (indexPage > 1) indexPage--;

          //           experiments = experimentsAll.sublist(
          //               (nExperiments * (indexPage - 1) > 0)
          //                   ? (nExperiments * (indexPage - 1))
          //                   : 0,
          //               (nExperiments * indexPage) < experimentsAll.length
          //                   ? (nExperiments * indexPage)
          //                   : experimentsAll.length);
          //         });
          //       },
          //     ),
          //   ),
          //   SizedBox(
          //     width: 20,
          //   ),
          //   CircleAvatar(
          //     backgroundColor: Colors.blue,
          //     radius: 20,
          //     child: IconButton(
          //       padding: EdgeInsets.zero,
          //       icon: Icon(Icons.arrow_forward),
          //       color: Colors.white,
          //       onPressed: () {
          //         setState(() {
          //           if ((nExperiments * indexPage) < experimentsAll.length)
          //             indexPage++;
          //           experiments = experimentsAll.sublist(
          //               (nExperiments * (indexPage - 1)),
          //               (nExperiments * indexPage) < experimentsAll.length
          //                   ? (nExperiments * indexPage)
          //                   : experimentsAll.length);
          //         });
          //       },
          //     ),
          //   ),
          // ]),

          //Spacer()
        ]),
      );
  }
}
