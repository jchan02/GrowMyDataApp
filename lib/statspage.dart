import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;

List<charts.Series<PlantReading, DateTime>> getLight() {
  final data1 = plantProbes[0].readings;
  final data2 = plantProbes[1].readings;
  final data3 = plantProbes[2].readings;
  final data4 = plantProbes[3].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.light,
      data: data1,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.light,
      data: data2,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.light,
      data: data3,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.light,
      data: data4,
    )
  ];
}

List<charts.Series<PlantReading, DateTime>> getMoisture() {
  final data1 = plantProbes[0].readings;
  final data2 = plantProbes[1].readings;
  final data3 = plantProbes[2].readings;
  final data4 = plantProbes[3].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.moisture,
      data: data1,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.moisture,
      data: data2,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.moisture,
      data: data3,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.moisture,
      data: data4,
    )
  ];
}

List<charts.Series<PlantReading, DateTime>> getHumidity() {
  final data1 = plantProbes[0].readings;
  final data2 = plantProbes[1].readings;
  final data3 = plantProbes[2].readings;
  final data4 = plantProbes[3].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.humidity,
      data: data1,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.humidity,
      data: data2,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.humidity,
      data: data3,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.humidity,
      data: data4,
    )
  ];
}

List<charts.Series<PlantReading, DateTime>> getTemperature() {
  final data1 = plantProbes[0].readings;
  final data2 = plantProbes[1].readings;
  final data3 = plantProbes[2].readings;
  final data4 = plantProbes[3].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => globals.tempUseF ? reading.temperature : ((reading.temperature - 32) * 5/9),
      data: data1,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => globals.tempUseF ? reading.temperature : ((reading.temperature - 32) * 5/9),
      data: data2,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => globals.tempUseF ? reading.temperature : ((reading.temperature - 32) * 5/9),
      data: data3,
    ),
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => globals.tempUseF ? reading.temperature : ((reading.temperature - 32) * 5/9),
      data: data4,
    )
  ];
}

class Statspage extends StatefulWidget {
  @override
  _StatspageState createState() => _StatspageState();
}

class _StatspageState extends State<Statspage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 55.0, right: 10, top: 10, bottom: 10),
      child: (globals.email == '') ? Center(child: Text((plantProbes.length == 0 && globals.email != '') ? 'No plants have been registered' : 'Sign in to view your plants', style: TextStyle(color: Theme.of(context).hintColor)))
      : Stack(
        children: <Widget> [
          ListView(
            children: <Widget> [
              Container(
                height: 200,
                child: charts.TimeSeriesChart(
                  getLight(),
                  animate: false,
                  behaviors: [
                    charts.ChartTitle(
                      'Sunlight Illuminance',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 16),
                      behaviorPosition: charts.BehaviorPosition.top,
                      innerPadding: 18
                    ),
                    charts.ChartTitle(
                      'Time',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                    charts.ChartTitle(
                      'Lux',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                  ],
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      day: charts.TimeFormatterSpec(
                        format: 'dd',
                        transitionFormat: 'MMM dd',
                      ),
                      hour: charts.TimeFormatterSpec(
                        format: 'hh',
                        transitionFormat: 'MMM dd hh:mm',
                      ),
                      minute: charts.TimeFormatterSpec(
                        format: 'mm',
                        transitionFormat: 'MMM dd hh:mm',
                      ),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                  ),
                )
              ),
              Container(
                height: 200,
                child: charts.TimeSeriesChart(
                  getMoisture(),
                  animate: false,
                  behaviors: [
                    charts.ChartTitle(
                      'Moisture',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 16),
                      behaviorPosition: charts.BehaviorPosition.top,
                      innerPadding: 18
                    ),
                    charts.ChartTitle(
                      'Time',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                    charts.ChartTitle(
                      'Moisture (%)',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                  ],
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      hour: charts.TimeFormatterSpec(
                        format: 'dd',
                        transitionFormat: 'MMM dd',
                      ),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                  ),
                )
              ),
              Container(
                height: 200,
                child: charts.TimeSeriesChart(
                  getHumidity(),
                  animate: false,
                  behaviors: [
                    charts.ChartTitle(
                      'Humidity',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 16),
                      behaviorPosition: charts.BehaviorPosition.top,
                      innerPadding: 18
                    ),
                    charts.ChartTitle(
                      'Time',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                    charts.ChartTitle(
                      'Humidity (%)',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                  ],
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      hour: charts.TimeFormatterSpec(
                        format: 'dd',
                        transitionFormat: 'MMM dd',
                      ),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                  ),
                )
              ),
              Container(
                height: 200,
                child: charts.TimeSeriesChart(
                  getTemperature(),
                  animate: false,
                  behaviors: [
                    charts.ChartTitle(
                      'Temperature',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 16),
                      behaviorPosition: charts.BehaviorPosition.top,
                      innerPadding: 18
                    ),
                    charts.ChartTitle(
                      'Time',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                    charts.ChartTitle(
                      globals.tempUseF ? 'Temperature (°F)' : 'Temperature (°C)',
                      titleStyleSpec: charts.TextStyleSpec(color: globals.darkMode ? charts.Color.white : charts.Color.black, fontSize: 10),
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea
                    ),
                  ],
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      hour: charts.TimeFormatterSpec(
                        format: 'dd',
                        transitionFormat: 'MMM dd',
                      ),
                      minute: charts.TimeFormatterSpec(
                        format: 'mm',
                        transitionFormat: 'MMM dd',
                      ),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 10, // size in Pts.
                        color: globals.darkMode ? charts.Color.white : charts.Color.black
                      )
                    ),
                  ),
                )
              )
            ]
          )
        ]
      )
    );
  }
}