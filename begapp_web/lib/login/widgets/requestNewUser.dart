import 'dart:convert';

import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/dialogs.dart';
import 'package:begapp_web/classes/maxLength.dart';
import 'package:begapp_web/login/classes/requestUserAdmin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class RequestNewUser extends StatefulWidget {
  final Function onCancel;
  final List<MaxLength> lengths;

  RequestNewUser({Key? key, required this.onCancel, required this.lengths})
      : super(key: key);

  @override
  _RequestNewUserState createState() => _RequestNewUserState();
}

class _RequestNewUserState extends State<RequestNewUser> {
  TextEditingController txtNewUsername = new TextEditingController();

  TextEditingController txtEmail = new TextEditingController();

  TextEditingController txtInstitution = new TextEditingController();

  TextEditingController txtIntention = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool requestExist = true;

  bool emailUnavailable = true;

  checkValidEmail() {
    final bool isValid = EmailValidator.validate(txtEmail.text);
    //print(isValid);
    return isValid;
  }

  checkEmail(value) async {
    String query =
        "SELECT * FROM `admin_user_request` WHERE email = '${txtEmail.text}' ";
    // //print("query" + query);
    var json = await Database.select(query);
    var emails = jsonDecode(json)['table_data'] as List;
    if (emails.length == 0)
      requestExist = false;
    else
      requestExist = true;
    query = "SELECT * FROM `AdminUser` WHERE email = '${txtEmail.text}'";
    //print("query" + query);
    json = await Database.select(query);
    emails = jsonDecode(json)['table_data'] as List;
    if (emails.length == 0)
      emailUnavailable = false;
    else
      emailUnavailable = true;
    //print("Email naõ aprovado: $requestExist");
    //print("Email existente: $emailUnavailable");

    _formKey.currentState!.validate();
  }

  onChanged(value) {
    _formKey.currentState!.validate();
  }

  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          checkEmail(txtEmail.text); //Check your conditions on text variable
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    validator(value) {
      if (value.isEmpty) {
        return AppLocalizations.of(context).translate('Required field');
      }
    }

    validateEmail(value) {
      // checkEmail(value);
      if (value.isEmpty) {
        return AppLocalizations.of(context).translate('Required field');
      }
      if (!checkValidEmail())
        return AppLocalizations.of(context).translate('invalidEmail');
      if (requestExist)
        return AppLocalizations.of(context).translate('emailWaiting');
      if (emailUnavailable)
        return AppLocalizations.of(context).translate('emailExist');
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double longest = MediaQuery.of(context).size.longestSide;
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

    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 40),
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
                      child: Container(
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('requestRegisterUser'),
                      style: TextStyle(
                          fontSize: longest * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: txtNewUsername,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: widget.lengths[0].CHARACTER_MAXIMUM_LENGTH,
                        decoration: setDecoration(
                            AppLocalizations.of(context).translate('name')),
                        // style: TextStyle(fontSize: 20),
                        validator: (value) => validator(value),
                      )),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: txtEmail,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: widget.lengths[1].CHARACTER_MAXIMUM_LENGTH,
                        decoration: setDecoration("Email"),
                        // style: TextStyle(fontSize: 20),
                        validator: (value) => validateEmail(value),
                      )),
                  Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: txtIntention,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: widget.lengths[2].CHARACTER_MAXIMUM_LENGTH,
                        maxLines: 4,
                        decoration: setDecoration(AppLocalizations.of(context)
                            .translate('newUserIntention')),
                        validator: (value) => validator(value),
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TextButton(
                            child: Text(
                                AppLocalizations.of(context).translate('send'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.04)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                AdminUserRequest adminUserRequest =
                                    new AdminUserRequest(
                                        0,
                                        txtNewUsername.text,
                                        txtEmail.text,
                                        txtIntention.text,
                                        false,
                                        AppLocalizations.of(context)
                                            .locale
                                            .languageCode);
                                await Database.requestRegisterNewUser(
                                    adminUserRequest);
                                txtEmail.text = "";
                                txtNewUsername.text = "";
                                txtIntention.text = "";
                                Dialogs.showMessageDialog(
                                    context,
                                    AppLocalizations.of(context)
                                        .translate('requestalreadySend'));
                                widget.onCancel();
                              }
                            })),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      // height: 40,
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context).translate('cancel'),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => widget.onCancel(),
                      ),
                    ),
                  ),
                ])));
  }
}
