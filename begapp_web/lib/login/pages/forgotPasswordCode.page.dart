import 'dart:convert';

import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/login/pages/resetPassword.page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ForgotPasswordCodePage extends StatelessWidget {
  final TextEditingController txtCode = new TextEditingController();

  late final _formKey = GlobalKey<FormState>();
  bool rightCode = false;
  String email;
  ForgotPasswordCodePage(this.email);
  List<int> flex = [2, 4, 3, 2];
  @override
  Widget build(BuildContext context) {
    onChanged(value) async {
      String query =
          "SELECT * FROM `AdminUser` WHERE email = '$email' AND code = '${txtCode.text}'";

      var json = await Database.select(query);
      var emails = jsonDecode(json)['table_data'] as List;
      if (emails.length == 0)
        rightCode = false;
      else
        rightCode = true;

      _formKey.currentState!.validate();
    }

    validator(value) {
      if (value.isEmpty) {
        return AppLocalizations.of(context).translate('Required field');
      }
      if (!rightCode)
        return AppLocalizations.of(context).translate('wrongCode');
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

    return Scaffold(
        body: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Container(
                height: height / 2,
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
                              flex: flex[0],
                              child: Container(
                                alignment: Alignment.center,
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
                              flex: flex[1],
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  AppLocalizations.of(context)
                                          .translate('forgotPasswordSend') +
                                      email,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .longestSide *
                                        0.012,
                                    color: Colors.black87,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: flex[2],
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: txtCode,
                                  keyboardType: TextInputType.emailAddress,
                                  // maxLength: lengths[0].character_maximum_length,
                                  decoration: setDecoration(
                                      AppLocalizations.of(context)
                                          .translate('inputCode')),
                                  onChanged: (value) => onChanged(value),
                                  validator: (value) => validator(value),
                                ),
                              )),
                          Expanded(
                            flex: flex[3],
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: TextButton(
                                    // child: Icon(
                                    //   Icons.arrow_forward_ios_rounded,
                                    //   size: height * 0.04,
                                    //   color: Colors.white,
                                    // ),
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('continue'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height * 0.04)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPasswordPage(email)));
                                      }
                                    })),
                          ),
                        ])))));
  }
}
