import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/login/pages/RequestsPage.dart';
import 'package:begapp_web/login/loginSettings.dart';
import 'package:begapp_web/main.dart';
import 'package:flutter/material.dart';
import 'menu_item.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  double padding = 0;
  double size = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(46),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 30,
              color: Colors.black.withOpacity(0.16),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 50,
              alignment: Alignment.topCenter,
            ),
            MenuItem(
              title: "Home",
              press: () {
                print("AAAAAAAAAAAA");
                Navigator.pushReplacementNamed(context, "/homepage");
              },
            ),
            // MenuItem(
            //     title: "baixar jogo",
            //     press: () => launch('https://forms.gle/86uhyWx4SgX2v6To6')),
            // MenuItem(
            //   title: "about",
            //   press: () {
            //     // Dialogs.showRequests(context);
            //     Navigator.pushReplacementNamed(context, RequestsPage.routeName);
            //   },
            // ),
            if (localStorage.getString('userType') == "master")
              Tooltip(
                  message: "Solicitações de Cadastro",
                  child: InkWell(
                    child: Icon(Icons.person_add_rounded),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, RequestsPage.routeName),
                  )),
            Spacer(),
            Column(
              children: [
                Text(AppLocalizations.of(context).translate('welcome') +
                    ", " +
                    localStorage.getString('username')!),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextButton(
                      child: Text(
                        AppLocalizations.of(context).translate('logout'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          LoginSettings.logout();
                          Navigator.pushReplacementNamed(context, '/login');
                        });
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
