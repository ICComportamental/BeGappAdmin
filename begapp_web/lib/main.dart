import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/login/pages/Register.page.dart';
import 'package:begapp_web/login/pages/RequestsPage.dart';
import 'package:begapp_web/login/pages/login.page.dart';
import 'package:begapp_web/login/loginSettings.dart';
import 'package:begapp_web/login/pages/forgotPasswordSendEmail.page.dart';
import 'package:begapp_web/pages/home.page.dart';
import 'package:begapp_web/prisoner_dilemma/pages/DilemmaExperimentsTable.page.dart';
import 'package:begapp_web/prisoner_dilemma/pages/DilemmaParticipants.page.dart';
import 'package:begapp_web/public_goods/pages/PGParticipants.dart';
import 'package:begapp_web/public_goods/pages/PublicGoodsExperiments.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppLanguage.dart';
import 'login/classes/adminUser.dart';
import 'mytestpage.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception}',
        style: TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  LoginSettings loginSettings = LoginSettings();
  runApp(MyApp(
    appLanguage: appLanguage,
    loginSettings: loginSettings,
  ));
}

late SharedPreferences localStorage;

TextEditingController username = new TextEditingController();
TextEditingController password = new TextEditingController();
// TextEditingController username = new TextEditingController(text: "yas");
// TextEditingController password = new TextEditingController(text: "asdf");
late AdminUser adminUser;

class MyApp extends StatelessWidget {
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  final AppLanguage appLanguage;
  final LoginSettings loginSettings;
  MyApp({required this.appLanguage, required this.loginSettings});
  @override
  Widget build(BuildContext context) {
    print("V3 - C minusculo");
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          appLanguage.changeLanguage(Locale("pt"));
          return MaterialApp(
            initialRoute: "/login",
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/login': (context) => LoginPage(),
              HomePage.routeName: (context) => HomePage(),
              RegisterPage.routeName: (context) => RegisterPage(),
              ForgotPasswordSendEmailPage.routeName: (context) =>
                  ForgotPasswordSendEmailPage(),
              // ForgotPasswordCodePage("yasmin.carolina12@gmail.com"),
              // ResetPasswordPage("usuario@gmail.com"),

              RequestsPage.routeName: (context) => RequestsPage(),
              PublicGoodsExperimentsPage.routeName: (context) =>
                  PublicGoodsExperimentsPage(),
              PGParticipants.routeName: (context) => PGParticipants(),
              DilemmaExperimentsTablePage.routeName: (context) =>
                  DilemmaExperimentsTablePage(),
              DilemmaParticipantsPage.routeName: (context) =>
                  DilemmaParticipantsPage(),
            },
            title: 'BeGapp Admin',
            locale: model.appLocal,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('pt', 'BR'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            // home:
            // HomePage(new AdminUser(5, 'username', 'password', 'email', 'userType'))
            // ExcelPage()
            // LoginPage()
            //LoginScreen()
            // PublicGoodsVariablesEditForm()
            // PublicGoodsTable()
            // DilemmaTablePage()
            // PGParticipants()
            // MyHomePage(title: 'BeGapp Admin'),
            // GraphicWeb()
            // PGDuration()
            home: TestPage(),
          );
        }));
  }
}
