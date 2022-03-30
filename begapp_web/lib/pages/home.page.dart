import 'dart:math';

import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/circular_menu/src/circular_menu.dart';
import 'package:begapp_web/circular_menu/src/circular_menu_item.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/prisoner_dilemma/pages/DilemmaExperimentsTable.page.dart';
import 'package:begapp_web/public_goods/pages/PublicGoodsExperiments.page.dart';
import 'package:begapp_web/widgets/app_bar.dart';
import 'package:begapp_web/widgets/futureCheckLogin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // final AdminUser adminUser;
  static const routeName = '/homepage';
  HomePage();
  // HomePage(this.adminUser);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  double spacer = 1;
  @override
  Widget build(BuildContext context) {
    spacer = MediaQuery.of(context).size.height * 0.3;
    // Database.generateKey();
    game({
      required String imgPath,
      required Function addFunction,
      required Function seeExperimentsFunction,
      required String gameName,
    }) {
      return Flex(
        direction: Axis.vertical,
        children: [
          CircularMenu(
              alignment: Alignment.topCenter,
              radius: 100,
              backgroundWidget: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imgPath))),
              ),
              animationDuration: Duration(milliseconds: 150),
              curve: Curves.bounceOut,
              reverseCurve: Curves.fastOutSlowIn,
              startingAngleInRadian: 0,
              endingAngleInRadian: pi / 4,
              toggleButtonColor: Colors.transparent,
              toggleButtonIconColor: Colors.transparent,
              toggleButtonMargin: 10.0,
              toggleButtonPadding: 10.0,
              toggleButtonSize: 80.0,
              items: [
                CircularMenuItem(
                    tooltip:
                        AppLocalizations.of(context).translate('addExperiment'),
                    icon: Icons.add,
                    onTap: () => addFunction()),
                CircularMenuItem(
                    tooltip: AppLocalizations.of(context)
                        .translate('seeExperiments'),
                    icon: Icons.grid_on,
                    onTap: () => seeExperimentsFunction()),
              ]),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(
            gameName,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.02),
          ),
        ],
      );
    }

    return FutureCheckLogin(
      page: Scaffold(
        body: Scrollbar(
          isAlwaysShown: true,
          child: ListView(
            children: [
              CustomAppBar(),
              SizedBox(
                height: spacer,
              ),
              Center(
                  child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: MediaQuery.of(context).size.width / 6,
                children: [
                  game(
                      imgPath: 'assets/userBlueGreen.png',
                      addFunction: () async {
                        await Dialogs.showAddDilemmaExperiment(context);
                        Dialogs.showGeneratedKeyDialog(
                          context,
                        );
                      },
                      seeExperimentsFunction: () {
                        Navigator.pushNamed(
                            context, DilemmaExperimentsTablePage.routeName);
                      },
                      gameName:
                          AppLocalizations.of(context).translate('dilemma')),
                  game(
                      imgPath: 'assets/moneyPig.png',
                      addFunction: () async {
                        await Dialogs.showAddPublicGoodsExperiment(context);
                        Dialogs.showGeneratedKeyDialog(
                          context,
                        );
                      },
                      seeExperimentsFunction: () {
                        Navigator.pushNamed(
                            context, PublicGoodsExperimentsPage.routeName);
                      },
                      gameName: AppLocalizations.of(context)
                          .translate('publicGoods')),
                ],
              )),

              // Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
