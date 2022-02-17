import 'package:begapp_web/app_localizations.dart';
import 'package:begapp_web/classes/connection.dart';
import 'package:begapp_web/classes/database.dart';
import 'package:begapp_web/classes/maxLength.dart';
import 'package:begapp_web/login/classes/adminUser.dart';
import 'package:begapp_web/login/pages/forgotPasswordSendEmail.page.dart';
import 'package:begapp_web/login/widgets/requestNewUser.dart';
import 'package:begapp_web/main.dart';
import 'package:begapp_web/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

// tabela userAdm
// id, username, password, email

// config dilemma
// config - public ou private
// resultados - public ou private
// admin id

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  int flexUsername = 2;
  int flexPassword = 3;
  int flexLogin = 2;
  int flexRegister = 2;

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Connection.showLoadingDialog(context, _keyLoader); //invoking login
      // bool con = await Connection.checkConnection(context);
      await loadingLogin(context);
      save();
    } catch (error) {
      print(error);
    }
  }

  //salvar login
  save() async {
    await MyApp.init();
    localStorage.setString('username', username.text.toString());
    localStorage.setBool('login', true);
  }

  //pegar login info
  // if (localStorage != null)
  //   Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: Text("User Logged in!!! ->  Email Id: ${localStorage.get('email')}  Password: ${localStorage.get('password')}",style: TextStyle(fontSize: 20),),
  //   ),

  loadingLogin(BuildContext context) async {
    List jsonList;

    jsonList = await Database.validateLogin(username.text, password.text);
    await MyApp.init();
    if (jsonList.length > 0) {
      await Future.delayed(
        Duration(
          seconds: 2,
        ),
      );
      Navigator.of(
        _keyLoader.currentContext!,
      ).pop();
      adminUser = AdminUser.fromJson(jsonList[0]);
      localStorage.setString('userType', adminUser.userType);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => HomePage(adminUser)));
      Navigator.pushNamed(context, HomePage.routeName, arguments: adminUser);
    } else {
      Navigator.of(
        _keyLoader.currentContext!,
      ).pop(); //close the dialoge

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(
                  AppLocalizations.of(context).translate('invalidLogin'),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 30),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('ok'),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30),
                      )),
                ],
              ));
    }
  }

  List<MaxLength> lengths = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // username.text = "usuario";
    // password.text = "a";
    return Scaffold(
      body: Container(
          color: Colors.blue,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: width / 3, vertical: height / 10),
          child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              front: Container(
                  // container do login
                  margin: EdgeInsets.symmetric(vertical: height / 7),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 30, vertical: height / 30),
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
                      child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        Expanded(
                            flex: flexUsername,
                            child: TextFormField(
                              controller: username,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('username'),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400,
                                    // fontSize:20,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  )),
                              // style: TextStyle(fontSize: 20),
                            )),
                        Expanded(
                            flex: flexPassword,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: password,
                                    keyboardType: TextInputType.text,
                                    obscureText: obscure,
                                    decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)
                                            .translate('password'),
                                        labelStyle: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400,
                                          // fontSize:20,
                                        ),
                                        suffixIcon: GestureDetector(
                                          child: Icon(obscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onTap: () {
                                            setState(() {
                                              obscure = !obscure;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10.0),
                                          ),
                                        )),
                                    // style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('forgotPassword'),
                                          style: TextStyle(color: Colors.blue),
                                          textAlign: TextAlign.left,
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              ForgotPasswordSendEmailPage
                                                  .routeName);
                                        },
                                      ),
                                    )),
                              ],
                            )),
                        // Expanded(
                        //   flex: 1,
                        //   child: TextFormField(
                        //     // autofocus: true,
                        //     controller: password,
                        //     keyboardType: TextInputType.text,
                        //     obscureText: obscure,
                        //     decoration: InputDecoration(
                        //         labelText: AppLocalizations.of(context)
                        //             .translate('password'),
                        //         labelStyle: TextStyle(
                        //           color: Colors.black38,
                        //           fontWeight: FontWeight.w400,
                        //           // fontSize:20,
                        //         ),
                        //         suffixIcon: GestureDetector(
                        //           child: Icon(obscure
                        //               ? Icons.visibility_off
                        //               : Icons.visibility),
                        //           onTap: () {
                        //             setState(() {
                        //               obscure = !obscure;
                        //             });
                        //           },
                        //         ),
                        //         border: OutlineInputBorder(
                        //           borderSide:
                        //               BorderSide(color: Colors.blueGrey),
                        //           borderRadius: const BorderRadius.all(
                        //             const Radius.circular(10.0),
                        //           ),
                        //         )),
                        //     // style: TextStyle(fontSize: 20),
                        //   ),
                        // ),
                        // Expanded(
                        //     flex: 1,
                        //     child: Container(
                        //       alignment: Alignment.centerLeft,
                        //       child: InkWell(
                        //         child: Text(
                        //           AppLocalizations.of(context)
                        //               .translate('forgotPassword'),
                        //           style: TextStyle(color: Colors.blue),
                        //           textAlign: TextAlign.left,
                        //         ),
                        //         onTap: () {},
                        //       ),
                        //     )),
                        Expanded(
                          flex: flexLogin,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: TextButton(
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height * 0.04)),
                                  onPressed: () => _handleSubmit(context))),
                        ),
                        // Container(
                        //   child: Text("Ainda não possui cadastro?"),
                        // ),
                        Expanded(
                          flex: flexRegister,
                          child: Container(
                            height: 40,
                            child: TextButton(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('register'),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () async {
                                lengths = [];
                                lengths.add(MaxLength(
                                    await Database.getMaxLength(
                                        'admin_user_request', 'name')));
                                lengths.add(MaxLength(
                                    await Database.getMaxLength(
                                        'admin_user_request', 'email')));
                                lengths.add(MaxLength(
                                    await Database.getMaxLength(
                                        'admin_user_request', 'intention')));
                                setState(() {
                                  cardKey.currentState!.toggleCard();
                                });
                              },
                            ),
                          ),
                        ),
                      ]))),
              back: RequestNewUser(
                lengths: lengths.length > 0
                    ? lengths
                    : [MaxLength(10), MaxLength(10), MaxLength(10)],
                onCancel: () {
                  setState(() {
                    cardKey.currentState!.toggleCard();
                  });
                },
              )
              //  Container(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: width / 30, vertical: height / 30),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color(0x80000000),
              //         blurRadius: 30.0,
              //         offset: Offset(0.0, 5.0),
              //       ),
              //     ],
              //   ),
              //   child: Text("restrarnd....."),
              // ),
              )),
    );
  }
}
