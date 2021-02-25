import 'package:flutter/material.dart';
import 'package:gmd_project/model/plant_model.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 3.0,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 56.0),
        itemBuilder: (context, counter) {
          return HomePlantView(
            id: plantProbes[counter].id,
            name: plantProbes[counter].name,
            readings: plantProbes[counter].readings,
          );
        },
        itemCount: plantProbes.length,
      )
    );
  }
}

class HomePlantView extends StatefulWidget {
  final String id;
  final String name;
  final List<PlantReading> readings;
  HomePlantView({this.id, this.name, this.readings});
  @override
  _HomePlantViewState createState() => _HomePlantViewState();
}

class _HomePlantViewState extends State<HomePlantView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFE5E5E5),
            border: Border.all(
              color: Color(0xFF969696),
              width: 2.0,
            )
          ),
          margin: EdgeInsets.all(8.0),
          width: 125,
          height: 125,
          child: Center(child: Text(widget.name)),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
              border: Border.all(
                color: Color(0xFF969696),
                width: 2.0,
              )
            ),
            margin: EdgeInsets.all(8.0),
            width: 125,
            height: 125,
            child: Column(
              children: <Widget> [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      color: (widget.readings.last.lightQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.lightQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.lightQuality)).round(), 0),
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF969696),
                          width: 2.0,
                        )
                      )
                    ),
                    child: Row(
                      children: <Widget> [
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.black,
                        ),
                        Expanded(child: Align(child: Text(widget.readings.last.light.toString()), alignment: Alignment.centerRight)),
                      ]
                    )
                  )
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: (widget.readings.last.moistureQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.moistureQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.moistureQuality)).round(), 0),
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF969696),
                          width: 2.0,
                        )
                      )
                    ),
                    child: Row(
                      children: <Widget> [
                        Icon(
                          Icons.opacity,
                          color: Colors.black,
                        ),
                        Expanded(child: Align(child: Text(widget.readings.last.moisture.toString()), alignment: Alignment.centerRight)),
                      ]
                    )
                  )
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: (widget.readings.last.humidityQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.humidityQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.humidityQuality)).round(), 0),
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF969696),
                          width: 2.0,
                        )
                      )
                    ),
                    child: Row(
                      children: <Widget> [
                        Icon(
                          Icons.wb_cloudy_outlined,
                          color: Colors.black,
                        ),
                        Expanded(child: Align(child: Text(widget.readings.last.humidity.toString()), alignment: Alignment.centerRight)),
                      ]
                    )
                  )
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: (widget.readings.last.temperatureQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.temperatureQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.temperatureQuality)).round(), 0),
                    ),
                    child: Row(
                      children: <Widget> [
                        Icon(
                          Icons.thermostat_rounded,
                          color: Colors.black,
                        ),
                        Expanded(child: Align(child: Text(widget.readings.last.temperature.toString()), alignment: Alignment.centerRight)),
                      ]
                    )
                  )
                ),
              ]
            )
          )
        )
      ] 
    );
  }
}