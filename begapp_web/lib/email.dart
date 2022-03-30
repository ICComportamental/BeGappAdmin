import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendEmailTeste extends StatefulWidget {
  @override
  _SendEmailTesteState createState() => _SendEmailTesteState();
}

class _SendEmailTesteState extends State<SendEmailTeste> {
  late String message;
  late String btnText;
  select(String lang) async {
    translateEmail(lang);

    // String url = "http://localhost/testeEmail/sendEmail.php";
    String url = "https://v1.begapp.com.br/EmailBody.php";
    // var res = await http.get(
    //   Uri.parse(url),
    // );
    var res = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "message": message,
      "btnText": btnText,
    });
    emailBody = res.body;
    return res.body;
  }

  translateEmail(String lang) {
    switch (lang) {
      case "en":
        message = """<p>Hello!</p>
        <p>Congratulations! Your request to be part of the BeGapp system has been approved!</p>
        <p>Click on the button below to proceed with the registration</p>
        <p>Welcome!</p>""";
        btnText = "Register BeGapp";
        break;
      case "pt":
        message = """<p>Olá!</p>
        <p>Parabéns! Sua solicitação para fazer parte do sistema BeGapp foi aprovada!</p>
        <p>Clique no botão abaixo para prosseguir com o cadastro</p>
        <p>Seja Bem vindo(a)!</p>""";
        btnText = "Cadastro BeGapp";
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("TOP:" + appLanguage.appLocal.toString());

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
                child: Text("Print lang"),
                onPressed: () async {
                  String lang = "pt";
                  //traduz o email para o idioma de quem requeriu o cadastro
                  translateEmail(lang);
                  String emailBody =
                      await Database.getEmailBody(message, btnText);
                  //Envia o email para que o cadastro do novo adm seja concluido
                  Database.sendgrid(
                      "yasmin.carolina12@gmail.com", btnText, emailBody);
                  // AppLocalizations.of(context).locale.languageCode;
                  // await select(lang);
                  // Database.sendEmail(
                  //     "yasmin.carolina12@gmail.com", btnText, emailBody);
                  // print(lang);
                  // // await appLanguage.fetchLocale();
                  // setState(() {
                  //   appLanguage.changeLanguage(Locale("en"));
                  //   print(appLanguage.appLocal);
                  //   print(AppLocalizations.of(context).locale);
                  // });
                }),
            TextButton(
              child: Text(AppLocalizations.of(context).translate("send")),
              onPressed: () async {
                await select("pt");
                Database.sendgrid("yasmin.carolina12@gmail.com",
                    "Cadastro BeGapp", emailBody);
                // "Sua solicitação de cadastro foi aprovada, clique no link para prosseguir com o cadastro: " +
                //     "<a href='https://v1.begapp.com.brAdmin/#/RegisterPage'>https://v1.begapp.com.brAdmin/#/RegisterPage</a>");
              },
            ),
          ],
        ),
      ),
    );
  }

  late String emailBody;
}
