import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/login/classes/requestUserAdmin.dart';
import 'package:begapp_web/login/pages/RequestsPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RequestDetails extends StatelessWidget {
  AdminUserRequest request;
  RequestDetails(this.request);
  late String message;
  late String btnText;

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    item(String title, String info) {
      return Container(
          alignment: Alignment.centerLeft,
          // padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.01),
          width: width * 0.5,
          // height: height * 0.15,
          // width: MediaQuery.of(context).size.width * 0.1,
          // height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                color: Colors.indigoAccent,
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: SelectableText(
                  //title + ": " +
                  info,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ));
    }

    return Container(
        alignment: Alignment.center,
        child: Scrollbar(
            isAlwaysShown: true,
            child: ListView(children: [
              SizedBox(
                height: height * 0.05,
              ),
              item(
                  AppLocalizations.of(context).translate('name'), request.name),
              item(AppLocalizations.of(context).translate('email'),
                  request.email),
              item(AppLocalizations.of(context).translate('intention'),
                  request.intention),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.2, vertical: height * 0.04),
                  height: height * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        await Database.update(
                            "UPDATE  `admin_user_request` SET `approved`=true WHERE id=" +
                                request.id.toString());
                        //traduz o email para o idioma de quem requeriu o cadastro
                        translateEmail(request.lang);
                        String emailBody =
                            await Database.getEmailBody(message, btnText);
                        //Envia o email para que o cadastro do novo adm seja concluido
                        Database.sendgrid(request.email, btnText, emailBody);
                        Navigator.pushReplacementNamed(
                            context, RequestsPage.routeName);
                      },
                      child: Text(
                          AppLocalizations.of(context).translate('approve'),
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.04)))),
            ])));
  }
}
