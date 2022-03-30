import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/email.dart';
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
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppLanguage.dart';
import 'classes/database.dart';
import 'login/classes/adminUser.dart';
import 'login/pages/forgotPasswordCode.page.dart';
import 'login/pages/resetPassword.page.dart';
import 'mytestpage.dart';
import 'public_goods/modals/createExperiment.dart';

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
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          appLanguage.changeLanguage(Locale("en"));
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
              MyHomePage.routeName: (context) => MyHomePage(
                    title: "email",
                  ),
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  static const routeName = '/myhomepage';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = '';
  // var email = Email('yasmin.carolina12@gmail.com', '834411Ya');

  // void _sendEmail() async {
  //   bool result = await email.sendMessage('Sua mensagem de email',
  //       'yasmin.carolina12@gmail.com', 'Seu assunto do email');

  //   setState(() {
  //     _text = result ? 'Enviado.' : 'Não enviado.';
  //   });
  // }

  void _checkEmail() {
    String email = "fhwefwfbfbqkhfiojfisdmsfnhiusafas@terra.com.br";
    final bool isValid = EmailValidator.validate(email);
    // print(isValid);
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SelectableText(
                "Gilmore Girls é uma série de televisão norte-americana, de comédia dramática, criado por Amy Sherman-Palladino e protagonizada por Lauren Graham e Alexis Bledel. A série estreou em 5 de outubro de 2000 pela The WB e tornou-se uma série emblemática para a rede. Gilmore Girls originalmente teve sete temporadas, com a temporada final mudada para a The CW, e terminou sua transmissão em 15 de maio de 2007. O principal foco do programa é a relação entre a mãe solteira Lorelai Gilmore e sua filha Rory, que moram em Stars Hollow, Connecticut, uma pequena cidade fictícia com personagens bem peculiares. A série explora questões familiares, românticas, educacionais e sobre amizades, juntamente com divisões das classes sociais, o último tema é sobre a difícil relação de Lorelai com seus pais da alta sociedade, Emily e Richard, as experiências de Rory em uma escola de elite e posteriormente na Universidade de Yale. Sherman-Palladino, que foi a showrunner da série, inseriu em Gilmore Girls distintos diálogos, repletos de referências da cultura pop. Após a sexta temporada, quando a série foi movida para a CW, Sherman-Palladino deixou a série e foi substituída por David S. Rosenthal na temporada final. A série foi produzida e distribuída pela Warner Bros. Television e filmada no estúdio em Burbank, Califórnia. Em 2016, a Netflix confirmou o retorno da série,[1] com quatro novos episódios de 90 minutos de duração que foram disponibilizados para streaming no mesmo ano. Os novos episódios foram escritos e dirigidos pela própria criadora da série e seu marido, Daniel Palladino, sob o título Gilmore Girls: A Year in the Life.")
            // Text(
            //   'Configurando um SMTP server: $_text',
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.email),
        onPressed: //_checkEmail, //Database.sendEmail,
            () {
          // Clipboard.setData(new ClipboardData(text: "Gilmore Girls"));
          // key.currentState.showSnackBar(new SnackBar(
          //   content: new Text("Copied to Clipboard"),
          // ));
        },
        tooltip: 'Send email',
      ),
    );
  }
}
