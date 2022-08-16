import 'package:begapp_web/DatatableElements/Datatable.dart';
import 'package:begapp_web/DatatableElements/classes/search.dart';
import 'package:begapp_web/DatatableElements/pagedTable.dart';
import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/prisoner_dilemma/classes/dilemmaVariables.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DilemmaExperimentsTable extends StatefulWidget {
  List<DilemmaVariables> experiments;

  DilemmaExperimentsTable(
    this.experiments,
  );
  @override
  _DilemmaExperimentsTableState createState() =>
      _DilemmaExperimentsTableState();
}

class _DilemmaExperimentsTableState extends State<DilemmaExperimentsTable> {
  List<DilemmaVariables> experimentsAll = [];
  List<DilemmaVariables> experiments = [];
  Alignment headerAlign = Alignment.center;
  Alignment rowsAlign = Alignment.center;
  DateFormat f = new DateFormat("dd/MM/yyyy");
  int nExperiments = 8;
  int indexPage = 1;
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

  void next() {}

  int searchFlex = 1;
  int tableFlex = 4;
  int btnFlex = 1;
  space() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagedTable(
      search: new Search([
        AppLocalizations.of(context).translate('name'),
        AppLocalizations.of(context).translate('key'),
        AppLocalizations.of(context).translate('creator'),
      ], [
        "gameName",
        "key",
        "adminId"
      ], (String column, String txtSearch, bool active) async {
        List list =
            await Database.searchDilemmaExperiments(column, txtSearch, active);
        // print(list);
        setState(() {
          indexPage = 1;
          experimentsAll = [];
          for (int i = 0; i < list.length; i++) {
            experimentsAll.add(DilemmaVariables.fromJson(list[i]));
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
          // AppLocalizations.of(context).translate('desc'),
          AppLocalizations.of(context).translate('edit'),
          AppLocalizations.of(context).translate('results'),
          "download",
          "status"
        ],
      ),
      // Container(),
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
  }
}
