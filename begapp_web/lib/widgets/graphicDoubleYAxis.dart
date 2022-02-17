// import 'package:begapp_web/app_localizations.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class GraphicDoubleY extends StatelessWidget {
//   final List<FlSpot> f1;
//   final List<FlSpot> f2;
//   final Color colors1;
//   final Color colors2;
//   final String title1;
//   final String title2;
//   final double maxChips;
//   final double maxRounds;
//   final double maxWallet;
//   final double gWidth;
//   final double fontSize;
//   final double subtitleSquad;
//   GraphicDoubleY(this.f1,this.f2,this.colors1,this.colors2,this.title1,this.title2,this.maxChips,this.maxRounds,this.maxWallet,this.gWidth,this.fontSize,this.subtitleSquad);

// //  higherValue(List<FlSpot> spots){
// //     double value=0;
// //     for(int i=0;i<spots.length;i++){
// //       if(spots[i].isNotNull()){
// //       //  print(i);
// //       if(value<spots[i].y)value=spots[i].y;

// //       }
// //     }
// //     return value;
// //   }

//   @override
//   Widget build(BuildContext context) {
//    // if(f1.last.isNull())f1.removeLast();
//     return
//      Container(//color: Colors.green,
//      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:[
//             //LEGENDAS
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     width:subtitleSquad,
//                     height:subtitleSquad,
//                     color:colors1
//                   ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal:5),
//                   child: Text(title1,
//                     style: TextStyle(
//                       fontSize:fontSize
//                     ),
//                   ),
//                 ),
//                 Container(
//                     width:subtitleSquad,
//                     height:subtitleSquad,
//                     color:colors2
//                   ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal:5),
//                   child: Text(title2,
//                     style: TextStyle(
//                       fontSize:fontSize
//                     ),)
//                 ),
//                 ],
//               ),

//        SizedBox(height: gWidth/20,),

//             //  Padding(
//             //    padding: EdgeInsets.only(top:screenHeight/30),
//             //    child:
//                 Stack(
//                 children:[
//                   SizedBox(
//                   width: gWidth,height:0.75*gWidth,
//                   child:
//                   LineChart(
//                     LineChartData(
//                       gridData: FlGridData(show:false),
//                       axisTitleData: FlAxisTitleData(
//                         leftTitle: AxisTitle(
//                           showTitle:true,
//                           titleText:title1,
//                           textStyle: TextStyle(
//                             fontSize:fontSize,
//                             color: Colors.black
//                           )
//                         ),
//                         rightTitle: AxisTitle(
//                           showTitle:true,
//                           titleText:"",
//                           textStyle: TextStyle(
//                             fontSize:fontSize,
//                             color: Colors.black
//                           )
//                         ),
//                         bottomTitle: AxisTitle(
//                           showTitle:true,
//                           titleText:AppLocalizations.of(context).translate('round'),
//                           textStyle: TextStyle(
//                             fontSize:fontSize,
//                             color: Colors.black
//                           )
//                         ),
//                       ),

//                       borderData: FlBorderData(
//                         show:true,
//                         border: Border(
//                           left: BorderSide(),
//                           bottom: BorderSide(),
//                         )
//                       ),
//                       lineTouchData:  LineTouchData(enabled: false),
//                       lineBarsData: [
//                         LineChartBarData(
//                          // dashArray: [3],
//                           show: true,
//                           spots:f1,
//                           isCurved: false,
//                           barWidth: 2,
//                           colors: [
//                             colors1,
//                           ],
//                           dotData: FlDotData(
//                            // show: true,

//                             dotColor: colors1,
//                             checkToShowDot: (spot){

//                               if(spot.isNull()) {
//                                 return false;
//                               }
//                               else return true;
//                             }
//                           ),
//                         ),

//                       ],
//                       maxY: maxChips,//higherValue(f1),
//                       minY: 0,
//                       maxX: maxRounds,//f1.length.toDouble(),
//                       titlesData: FlTitlesData(
//                         bottomTitles: SideTitles(
//                           interval: (maxRounds>=10)?maxRounds/10:1,
//                             showTitles: true,
//                             textStyle:
//                                 TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
//                             getTitles: (value) {
//                               return value.toInt().toString();

//                             },),
//                         leftTitles: SideTitles(
//                           showTitles: true,
//                           getTitles: (value) {
//                             return (value++).toInt().toString();
//                           },
//                           textStyle:
//                             TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                         rightTitles: SideTitles(
//                           interval: maxWallet+1,
//                           showTitles: true,
//                           getTitles: (value) {
//                             return (value++).toInt().toString();
//                           },
//                           textStyle:
//                             TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 //SEGUNDO GRÁFICO
//                  SizedBox(
//                   width: gWidth,height:0.75*gWidth,
//                   child:
//                   LineChart(
//                     LineChartData(
//                       gridData: FlGridData(show:false),
//                       axisTitleData: FlAxisTitleData(
//                         leftTitle: AxisTitle(
//                           showTitle:true,
//                           titleText:"",
//                           textStyle: TextStyle(
//                             fontSize:fontSize,
//                             color: Colors.black
//                           )
//                         ),
//                         rightTitle: AxisTitle(
//                           showTitle:true,
//                           titleText:title2,
//                           textStyle: TextStyle(
//                             fontSize:fontSize,
//                             color: Colors.black
//                           )
//                         ),
//                         bottomTitle: AxisTitle(
//                           showTitle:true,
//                           titleText:AppLocalizations.of(context).translate('round'),
//                           textStyle: TextStyle(
//                             fontSize:fontSize,
//                             color: Colors.black
//                           )
//                         ),
//                       ),

//                       borderData: FlBorderData(
//                         show:true,
//                         border: Border(
//                           right: BorderSide(),
//                           bottom: BorderSide(),
//                         )
//                       ),
//                       lineTouchData: const LineTouchData(enabled: false),
//                       lineBarsData: [
//                         LineChartBarData(
//                           show: true,
//                           spots:f2,
//                           isCurved: false,
//                           barWidth: 2,
//                           colors: [
//                             colors2,
//                           ],
//                           dotData: FlDotData(
//                             show: true,
//                             dotColor: colors2,
//                           ),
//                         ),

//                       ],
//                       maxY: maxWallet,//higherValue(f2),
//                       minY: 0,
//                       maxX: maxRounds,
//                       titlesData: FlTitlesData(
//                         bottomTitles: SideTitles(
//                           interval: (maxRounds>=10)?maxRounds/10:1,
//                             showTitles: true,
//                             textStyle:
//                                 TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
//                             getTitles: (value) {
//                               return value.toInt().toString();

//                             },),
//                         leftTitles: SideTitles(
//                           interval: maxWallet+1,//higherValue(f1)+higherValue(f2),
//                           showTitles: true,
//                           getTitles: (value) {
//                             return (value++).toInt().toString();
//                           },
//                           textStyle:
//                             TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                         rightTitles: SideTitles(
//                           interval: maxWallet/10,//higherValue(f2)/10,
//                           showTitles: true,
//                           getTitles: (value) {
//                             return (value++).toInt().toString();
//                           },
//                           textStyle:
//                             TextStyle(fontSize: fontSize/1.2, color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ])

//              //),

//           ])
//           //])
//      );
//   }
// }
