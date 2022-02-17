// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// // import 'dashboard_screen.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'BeGapp Login',
//       logo: 'assets/images/ecorp.png',
//       theme: LoginTheme(
//         primaryColor: Colors.blueGrey,
//         inputTheme: InputDecorationTheme(
//           enabledBorder: InputBorder.none,
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blueGrey),
//             borderRadius: const BorderRadius.all(
//               const Radius.circular(10.0),
//             ),
//           ) 
//         )
//       ),
//       onLogin: (_) => Future(null),
//       onSignup: (_) => Future(null),
//       // onSubmitAnimationCompleted: () {
//       //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//       //     builder: (context) => DashboardScreen(),
//       //   ));
//       // },
//       onRecoverPassword: (_) => Future(null),
//       messages: LoginMessages(
//         usernameHint: 'Username',
//         passwordHint: 'Pass',
//         confirmPasswordHint: 'Confirm',
//         loginButton: 'LOG IN',
//         signupButton: 'REGISTER',
//         forgotPasswordButton: 'Forgot huh?',
//         recoverPasswordButton: 'HELP ME',
//         goBackButton: 'GO BACK',
//         confirmPasswordError: 'Not match!',
//         recoverPasswordDescription:
//             'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
//         recoverPasswordSuccess: 'Password rescued successfully',
//       ),
//     );
//   }
// }