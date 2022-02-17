// import 'package:dilema_do_prisioneiro/classes/result.dart';
// import 'package:dilema_do_prisioneiro/classes/user.dart';
// import 'package:dilema_do_prisioneiro/widgets/graphic.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ResultPage extends StatelessWidget {
//   final User user; 
//   final List<Result> listResults;// = new List();
  
//   ResultPage({
//     @required this.user,
//     @required this.listResults
//   });

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double fontSize = screenWidth/25;
//     return Scaffold(
    
//       backgroundColor: Colors.white,
//       body: Container(
//         margin: EdgeInsets.only(
//           right: 20,
//           left: 20,
//           top: 30,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
    
//            Graphic(
//              compete: user.graphicCompete(listResults),
//              cooperate: user.graphicCooperate(listResults),
//            ),
            
//     //         Graphic(compete: 
     
//     //  const [
//     //             FlSpot(0, 0),
//     //             FlSpot(1, 3),
//     //             FlSpot(2, 4),
//     //             FlSpot(3, 5),
//     //             FlSpot(4, 8),
//     //             FlSpot(5, 3),
//     //             FlSpot(6, 5),
//     //             FlSpot(7, 8),
//     //             FlSpot(8, 4),
//     //             FlSpot(9, 7),
//     //             FlSpot(10, 7),
//     //             FlSpot(11, 8),
//     //           ],cooperate: const [
//     //             FlSpot(0, 4),
//     //             FlSpot(1, 3.5),
//     //             FlSpot(2, 4.5),
//     //             FlSpot(3, 1),
//     //             FlSpot(4, 4),
//     //             FlSpot(5, 6),
//     //             FlSpot(6, 6.5),
//     //             FlSpot(7, 6),
//     //             FlSpot(8, 4),
//     //             FlSpot(9, 6),
//     //             FlSpot(10, 6),
//     //             FlSpot(11, 7),
//     //           ],),
              
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Clique no link abaixo para responder ao questionário de Feedback.",
//                     textAlign: TextAlign.center,
//                     style:TextStyle(
//                               fontSize:fontSize,
//                               color: Colors.black
//                             )),
//                     SizedBox(height:fontSize),
//                     InkWell(
//                         child: new Text('Formulário de Feedback',
//                                       style: TextStyle(
//                                         decoration: TextDecoration.underline,
//                                         color: Colors.lightBlue,
//                                         fontSize: fontSize
//                                       ),
//                                       ),
//                         onTap: () => launch('https://docs.google.com/forms/d/e/1FAIpQLSchX7iARwKqA5lfJDOv4tHg3ohfMNby7VzDRC4DyFpVQvRfzA/viewform?usp=sf_link')
                    
//                   )
//               ],)
              
//           ],
//         ),
//       ),
//     );
//   }
// }