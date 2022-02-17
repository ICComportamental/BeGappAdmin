// import 'dart:async';
// // import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:begapp_web/prisoner_dilemma/widgets/graphic.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// // import 'package:teoria_dos_jogos/app_localizations.dart';
// // import 'package:teoria_dos_jogos/classes/pdf.dart';

// class GraphicWeb extends StatefulWidget {
//   // final List<RoundData> gameRounds;
//   // GraphicWeb({
//   //   @required this.gameRounds
//   // });

//   @override
//   _GraphicWebState createState() => _GraphicWebState();
// }

// class _GraphicWebState extends State<GraphicWeb> {
//   GlobalKey _globalKey = new GlobalKey();

//   bool inside = false;

//   late Uint8List imageInMemory;

//   late Image img;

//   Future<Uint8List> _capturePng() async {
//     try {
//       //print('inside');
//       inside = true;
//       RenderRepaintBoundary boundary =
//           _globalKey.currentContext.findRenderObject();
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List pngBytes = byteData.buffer.asUint8List();

//       //print('png done');
//       return pngBytes;
//     } catch (e) {
//       //print(e);
//     }
//   }

//   @override
//   void initState() {
//     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int div = 1;
//     double gWidth = (MediaQuery.of(context).size.width - 20) / div;
//     double fontSize = (MediaQuery.of(context).size.width / 25) / div;
//     double squadSize = (MediaQuery.of(context).size.width / 30) / div;
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     // double gWidth = MediaQuery.of(context).size.width-20;
//     // double fontSize=MediaQuery.of(context).size.width/25;
//     // double squadSize=MediaQuery.of(context).size.width/30;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//           // padding: EdgeInsets.symmetric(horizontal: screenWidth/40,vertical: screenWidth/40),
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           RepaintBoundary(
//               key: _globalKey,
//               child: Row(children: [
//                 //   GraphicDoubleY(
//                 // const [
//                 //       //FlSpot(0, 0),
//                 //       FlSpot(1, 5),
//                 //       FlSpot(2, 7),
//                 //       FlSpot(3, 7),
//                 //       FlSpot(4, 3),
//                 //       FlSpot(5, 4),
//                 //       FlSpot(6, 5),
//                 //       FlSpot(7, 3),
//                 //       FlSpot(8, 5),
//                 //       FlSpot(9, 5),
//                 //       FlSpot(10, 8),
//                 //       FlSpot(11, 5),
//                 //       FlSpot(12, 3),
//                 //       FlSpot(13, 2),
//                 //       FlSpot(14, 3),
//                 //       FlSpot(15, 3),
//                 //       FlSpot(16, 2),
//                 //       FlSpot(17, 1),
//                 //       FlSpot(18, 0),
//                 //       FlSpot(19, 0),
//                 //       FlSpot(20, 0),

//                 //     ],
//                 // const [
//                 //       //FlSpot(0, 0),
//                 //       FlSpot(1, 120),
//                 //       FlSpot(2,127),
//                 //       FlSpot(3, 130),
//                 //       FlSpot(4, 125),
//                 //       FlSpot(5, 100),
//                 //       FlSpot(6, 90),
//                 //       FlSpot(7, 115),
//                 //       FlSpot(8, 130),
//                 //       FlSpot(9, 111),
//                 //       FlSpot(10, 60),

//                 //       FlSpot(11, 80),
//                 //       FlSpot(12, 50),
//                 //       FlSpot(13, 110),
//                 //       FlSpot(14, 89),
//                 //       FlSpot(15, 97),
//                 //       FlSpot(16, 90),
//                 //       FlSpot(17, 120),
//                 //       FlSpot(18, 30),
//                 //       FlSpot(19, 20),
//                 //       FlSpot(20, 60),
//                 //   ],
//                 //    Colors.black, Colors.red, "Contribuição", "Carteira",
//                 //    10,20,gWidth,
//                 //    fontSize,squadSize),
//                 //   GraphicDoubleY(
//                 //     widget.gameRounds.map((roundData){
//                 //       return FlSpot(roundData.round.toDouble(), roundData.investment.toDouble());
//                 //     }).toList() ,
//                 //     widget.gameRounds.map((roundData){
//                 //       return FlSpot(roundData.round.toDouble(), roundData.wallet.toDouble());
//                 //     }).toList(),
//                 //       Colors.black, Colors.red, AppLocalizations.of(context).translate('contribution'), AppLocalizations.of(context).translate('walletTitle'),
//                 //       widget.gameRounds[0].variables.maxChips.toDouble(),widget.gameRounds[0].variables.maxRound.toDouble(),MediaQuery.of(context).size.width-20,
//                 //       MediaQuery.of(context).size.width/25,MediaQuery.of(context).size.width/30),
//                 Graphic(
//                   maxRounds: 50,
//                   defect: [
//                     //FlSpot(0, 0),
//                     FlSpot(1, 1),
//                     FlSpot(2, 0),
//                     FlSpot(3, 1),
//                     FlSpot(4, 0),
//                     FlSpot(5, 1),
//                     FlSpot(6, 0),
//                     FlSpot(7, 0),
//                     FlSpot(8, 1),
//                     FlSpot(9, 0),
//                     FlSpot(10, 1),
//                     FlSpot(11, 0),
//                     FlSpot(12, 1),
//                     FlSpot(13, 1),
//                     FlSpot(14, 1),
//                     FlSpot(15, 0),
//                     FlSpot(16, 0),
//                     FlSpot(17, 1),
//                     FlSpot(18, 0),
//                     FlSpot(19, 0),
//                     FlSpot(20, 0),
//                   ],
//                   cooperate: [
//                     //FlSpot(0, 0),
//                     FlSpot(1, 120),
//                     FlSpot(2, 127),
//                     FlSpot(3, 130),
//                     FlSpot(4, 125),
//                     FlSpot(5, 100),
//                     FlSpot(6, 90),
//                     FlSpot(7, 115),
//                     FlSpot(8, 130),
//                     FlSpot(9, 111),
//                     FlSpot(10, 60),

//                     FlSpot(11, 80),
//                     FlSpot(12, 50),
//                     FlSpot(13, 110),
//                     FlSpot(14, 89),
//                     FlSpot(15, 97),
//                     FlSpot(16, 90),
//                     FlSpot(17, 120),
//                     FlSpot(18, 30),
//                     FlSpot(19, 20),
//                     FlSpot(20, 60),
//                   ],
//                   //  Colors.black, Colors.red, "Contribuição", "Carteira",
//                   //  10,20,300 ,gWidth,
//                   //  fontSize,squadSize),
//                 )
//               ])),
//           RaisedButton(
//               child: Text("Download pdf"),
//               onPressed: () async {
//                 //Uint8List bytes = await _capturePng();
//                 // Uint8List bytes = await PdfWeb().getImage(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
//                 // img = Image.memory(bytes);
//                 // setState(() {

//                 // });
//                 //PdfWeb.download(PdfWeb().createPdf(bytes));
//               }),
//           ElevatedButton(
//               child: Text("Abrir pdf"),
//               onPressed: () async {
//                 //Uint8List bytes = await _capturePng();
//                 //PdfWeb.openPdf(PdfWeb().createPdf(bytes));
//               }),
//           if (img != null) Container(child: img)
//         ],
//       )),
//     );
//   }
// }

// // class ResultPubliGoods{
// //   returnSpots(List<RoundData> rounds){

// //   }
// // }
