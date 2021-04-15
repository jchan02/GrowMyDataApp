import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;

class Statspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 55.0, right: 10, top: 10, bottom: 10),
      child: Column(
        children: <Widget> [
          Container(padding: EdgeInsets.only(left: 45), child: Text('Light Measurements', style: TextStyle(color: Theme.of(context).hintColor))),
          SizedBox(width: 300, height: 200, child: LineChart(
            LineChartData(
              minX: 0,
              minY: 0,
              maxX: 11,
              maxY: 15000,
              axisTitleData: FlAxisTitleData(
                bottomTitle: AxisTitle(
                  showTitle: true,
                  textStyle: TextStyle(color: Theme.of(context).hintColor),
                  margin: 0,
                  titleText: 'Time',
                ),
                leftTitle: AxisTitle(
                  showTitle: true,
                  textStyle: TextStyle(color: Theme.of(context).hintColor),
                  margin: 0,
                  titleText: 'Lux',
                )
              ),
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                  ),
                  getTitles: (value) {
                    return globals.monthName[value.toInt()];
                  }
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                  ),
                )
              ),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Theme.of(context).buttonColor,
                    strokeWidth: 0.75,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Theme.of(context).buttonColor,
                    strokeWidth: 0.75
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Theme.of(context).buttonColor)
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(double.parse(plantProbes[0].readings[0].time.minute.toString()), plantProbes[0].readings[0].light),
                    FlSpot(double.parse(plantProbes[0].readings[1].time.minute.toString()), plantProbes[0].readings[1].light),
                  ],
                  colors: [Theme.of(context).primaryColor],
                )
              ]
            )
          )
        )]
      )
    );
  }
}