import 'package:begapp_web/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graphic extends StatefulWidget {
  final List<FlSpot> cooperate; //red
  final List<FlSpot> defect; //black
  final int maxRounds;
  Graphic(
      {required this.defect, required this.cooperate, required this.maxRounds});
  @override
  _GraphicState createState() => new _GraphicState();
}

class _GraphicState extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    double scale = 1;
    double screenWidth = MediaQuery.of(context).size.width * scale;
    double screenHeight = MediaQuery.of(context).size.height * scale;
    double subtitleSquad = screenHeight / 30;
    double fontSize = screenHeight / 25;
    double graphicWidth = MediaQuery.of(context).size.width / 2;
    double graphicHeight = MediaQuery.of(context).size.height / 2;
    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth / 36, vertical: 10),
        child: Flex(direction: Axis.vertical, children: [
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Container(
                  width: subtitleSquad,
                  height: subtitleSquad,
                  color: Colors.red),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  AppLocalizations.of(context).translate('cooperate'),
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              Container(
                  width: subtitleSquad,
                  height: subtitleSquad,
                  color: Colors.black),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    AppLocalizations.of(context).translate('defect'),
                    style: TextStyle(fontSize: fontSize),
                  )),
            ],
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight / 30,
                ),
                child: SizedBox(
                  width: graphicWidth,
                  height: graphicHeight,
                  // height: 140,
                  child: LineChart(
                    LineChartData(
                      // maxY: 50,
                      axisTitleData: FlAxisTitleData(
                        leftTitle: AxisTitle(
                            showTitle: true,
                            titleText: AppLocalizations.of(context)
                                .translate('frequency'),
                            textStyle: TextStyle(
                                fontSize: fontSize, color: Colors.black)),
                        bottomTitle: AxisTitle(
                            showTitle: true,
                            titleText:
                                AppLocalizations.of(context).translate('round'),
                            textStyle: TextStyle(
                                fontSize: fontSize, color: Colors.black)),
                      ),

                      borderData: FlBorderData(
                          show: true,
                          border: Border(
                            left: BorderSide(),
                            bottom: BorderSide(),
                          )),
                      lineTouchData: LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots:
                              //   [
                              //     FlSpot(0,1),
                              //     FlSpot(3,2),
                              //     FlSpot(0,1),
                              //     FlSpot(3,2),
                              // ],//
                              widget.defect,
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.black,
                          ],
                          dotData: FlDotData(
                            show: true,
                            // dotColor: Colors.black,
                          ),
                        ),
                        LineChartBarData(
                          spots:
                              // [
                              //     FlSpot(0,1),
                              //     FlSpot(3,2),
                              //     FlSpot(0,6),
                              //     FlSpot(3,8),
                              // ],//
                              widget.cooperate,
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.red,
                          ],
                          dotData: FlDotData(
                            show: true, /*dotColor: Colors.red*/
                          ),
                        ),
                      ],
                      maxY: widget.maxRounds.toDouble(),
                      minY: 0,
                      minX: 0,
                      maxX: widget.maxRounds.toDouble(),
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          interval: (widget.maxRounds >= 10)
                              ? widget.maxRounds / 10
                              : 1,
                          showTitles: true,
                          // textStyle: TextStyle(
                          //     fontSize: fontSize / 1.2,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.bold),
                          getTitles: (value) {
                            return value.toInt().toString();
                          },
                        ),
                        leftTitles: SideTitles(
                          interval: (widget.maxRounds >= 10)
                              ? widget.maxRounds / 10
                              : 1,
                          showTitles: true,
                          getTitles: (value) {
                            return (value++).toInt().toString();
                            // return '${value + 10}';
                          },
                          // textStyle: TextStyle(
                          //     fontSize: fontSize / 1.2,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.bold),
                        ),
                      ),
                      gridData: FlGridData(
                        show: false,
                        checkToShowHorizontalLine: (double value) {
                          return value == 1 ||
                              value == 6 ||
                              value == 4 ||
                              value == 5;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
