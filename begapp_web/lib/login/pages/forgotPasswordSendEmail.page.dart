// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/login/pages/forgotPasswordCode.page.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSendEmailPage extends StatelessWidget {
  final TextEditingController txtEmail = new TextEditingController();
  static const routeName = '/ForgotPassword';
  bool emailDoesntExist = false;
  final _formKey = GlobalKey<FormState>();
  ForgotPasswordSendEmailPage();

  int flexTitle = 2;
  int flexMessage = 4;
  int flexEmail = 4;
  int flexBtn = 4;

  @override
  Widget build(BuildContext context) {
    checkEmail() async {
      String query =
          "SELECT * FROM `AdminUser` WHERE email = '${txtEmail.text}'";

      var json = await Database.select(query);
      var emails = jsonDecode(json)['table_data'] as List;
      if (emails.length == 0)
        emailDoesntExist = true;
      else
        emailDoesntExist = false;

      _formKey.currentState!.validate();
    }

    validator(value) {
      if (value.isEmpty) {
        return AppLocalizations.of(context).translate('Required field');
      }
      if (emailDoesntExist)
        return AppLocalizations.of(context).translate('invalidEmail');
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setDecoration(String label) {
      return InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            // fontSize:20,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ));
    }

    // txtEmail.text = "usuario@gmail.com";
    return Scaffold(
      body: Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Container(
              height: height / 2.5,
              width: width / 3,
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x80000000),
                    blurRadius: 30.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: flexTitle,
                            child: Container(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('resetPassword'),
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .longestSide *
                                        0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: flexMessage,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('infoEmail'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.longestSide *
                                          0.012,
                                  color: Colors.black87,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: flexEmail,
                            child: TextFormField(
                              controller: txtEmail,
                              keyboardType: TextInputType.emailAddress,
                              // maxLength: lengths[0].character_maximum_length,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('email')),
                              // onChanged: (value) => onChanged(value),
                              validator: (value) => validator(value),
                            )),
                        Expanded(
                          flex: flexBtn,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('continue'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height * 0.04)),
                                  onPressed: () async {
                                    if (txtEmail.text.isNotEmpty)
                                      await checkEmail();
                                    if (_formKey.currentState!.validate()) {
                                      String timestamp = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString();
                                      var bytes = utf8.encode(
                                          timestamp); //transforma a senha em hash

                                      var digest = md5.convert(bytes);
                                      String code =
                                          digest.toString().substring(0, 6);

                                      String query =
                                          "UPDATE AdminUser SET code='$code' WHERE email = '${txtEmail.text}'";
                                      await Database.update(query);
                                      debugPrint("query:$query");
                                      try {
                                        await Database.sendgrid(
                                            txtEmail.text,
                                            AppLocalizations.of(context)
                                                .translate('resetPassword'),
                                            AppLocalizations.of(context)
                                                    .translate(
                                                        'resetPasswordMessage') +
                                                code);
                                      } catch (e) {
                                        print(e);
                                      }
                                      debugPrint("query:NEXT");
                                      String email = txtEmail.text;
                                      txtEmail.text = "";
                                      Dialogs.okDialog(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'forgotPasswordEmailSend'),
                                          context, onPop: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordCodePage(
                                                        email)));
                                      });
                                    }
                                  })),
                        ),
                      ])))),
    );
  }
}
