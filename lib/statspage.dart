import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;

List<charts.Series<PlantReading, DateTime>> getLight() {
  final data = plantProbes[0].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.light,
      data: data,
    )
  ];
}

List<charts.Series<PlantReading, DateTime>> getMoisture() {
  final data = plantProbes[0].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.moisture,
      data: data,
    )
  ];
}

List<charts.Series<PlantReading, DateTime>> getHumidity() {
  final data = plantProbes[0].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => reading.moisture,
      data: data,
    )
  ];
}

List<charts.Series<PlantReading, DateTime>> getTemperature() {
  final data = plantProbes[0].readings;
  return [
    charts.Series<PlantReading, DateTime>(
      id: 'Readings',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PlantReading reading, _) => reading.time,
      measureFn: (PlantReading reading, _) => globals.tempUseF ? reading.temperature : ((reading.temperature - 32) * 5/9),
      data: data,
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