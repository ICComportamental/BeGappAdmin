import 'package:begapp_web/DatatableElements/TableRows/datatableRows.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/login/classes/requestUserAdmin.dart';
import 'package:begapp_web/login/pages/RequestsPage.dart';
import 'package:flutter/material.dart';

String message = "";
String btnText = "";
List<DataCell> getAdminRequest(
    AdminUserRequest request, index, contextDialog, setstate) {
  List<DataCell> row = [];
  List<String> datas = [
    (index).toString(),
    request.name,
    request.email,
    request.intention
  ];

  datas.forEach((e) => row.add(DatatableRows.getCell(e)));
  row.add(DatatableRows.getSeeCell(
      condition: true,
      seeData: () async {
        await Dialogs.showRequestsDetails(contextDialog, request);
      }));
  row.add(DatatableRows.getApproveCell(
      condition: true,
      approve: () async {
        await Database.update(
            "UPDATE  `admin_user_request` SET `approved`=true WHERE id=" +
                request.id.toString());
        //traduz o email para o idioma de quem requeriu o cadastro
        translateEmail(request.lang);
        String emailBody = await Database.getEmailBody(message, btnText);
        //Envia o email para que o cadastro do novo adm seja concluido
        Database.sendgrid(request.email, btnText, emailBody);
        Navigator.pushReplacementNamed(contextDialog, RequestsPage.routeName);
      }));
  row.add(DatatableRows.getDenyCell(deny: () async {
    await Database.update(
        "DELETE from `admin_user_request` WHERE id=" + request.id.toString());

    Navigator.pushReplacementNamed(contextDialog, RequestsPage.routeName);
  }));
  return row;
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
