import 'dart:convert';

import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResetPasswordPage extends StatefulWidget {
  String email;
  ResetPasswordPage(this.email);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController txtPassword = new TextEditingController();
  final TextEditingController txtConfirm = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<int> flex = [2, 3, 3, 2];

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    validator(value) {
      if (value.isEmpty) {
        return AppLocalizations.of(context).translate('Required field');
      }
      bool differentPasswords = txtConfirm.text != txtPassword.text;
      if (differentPasswords)
        return AppLocalizations.of(context).translate('differentPasswords');
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setDecoration(String label, Function ontap, bool obscure) {
      return InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            // fontSize:20,
          ),
          suffixIcon: GestureDetector(
              child: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onTap: () => ontap()),
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
                                      .translate('newPassword'),
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
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: txtPassword,
                                  obscureText: obscurePassword,
                                  keyboardType: TextInputType.emailAddress,
                                  // maxLength: lengths[0].character_maximum_length,
                                  decoration: setDecoration(
                                      AppLocalizations.of(context)
                                          .translate('password'), () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  }, obscurePassword),
                                  validator: (value) => validator(value),
                                ),
                              )),
                          Expanded(
                              flex: flex[2],
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: txtConfirm,
                                  obscureText: obscureConfirm,
                                  keyboardType: TextInputType.emailAddress,
                                  // maxLength: lengths[0].character_maximum_length,
                                  decoration: setDecoration(
                                      AppLocalizations.of(context)
                                          .translate('confirmPassword'), () {
                                    setState(() {
                                      obscureConfirm = !obscureConfirm;
                                    });
                                  }, obscureConfirm),
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
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('confirm'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height * 0.04)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var bytes = utf8.encode(txtPassword
                                            .text); //transforma a senha em hash

                                        var digest = md5.convert(bytes);

                                        String password = digest.toString();
                                        String query =
                                            "UPDATE AdminUser SET password='$password',code='0' WHERE email = '${widget.email}'";
                                        await Database.update(query);

                                        await Dialogs.showMessageDialog(
                                            context,
                                            AppLocalizations.of(context)
                                                .translate('passwordReseted'),
                                            onPop: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/login');
                                        });
                                      }
                                    })),
                          ),
                        ])))));
  }
}
