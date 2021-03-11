import 'package:flutter/material.dart';
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;

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
            favorite: plantProbes[counter].favorite,
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
  final bool favorite;
  final List<PlantReading> readings;
  HomePlantView({this.id, this.name, this.favorite, this.readings});
  @override
  _HomePlantViewState createState() => _HomePlantViewState();
}

class _HomePlantViewState extends State<HomePlantView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        Column(
          children: <Widget> [
            Stack(
              children: <Widget> [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    border: Border.all(
                    color: Color(0xFF969696),
                    width: 2.0,
                   )
                  ),
                  margin: EdgeInsets.only(right: 8.0, left: 8.0),
                  width: 125,
                  height: 100,
                  child: Center(child: Icon(Icons.image_not_supported, color: Color(0xFFBFBFBF), size: 90.0)),
                ),
                Container(
                  margin: EdgeInsets.only(right: 9.0, left: 9.0, top: 1.0),
                  width: 23,
                  height: 12,
                  child: Icon(Icons.star, color: Color(0xFF969696), size: 25.0)
                ),
                if(widget.favorite == true) Container(
                  margin: EdgeInsets.only(right: 9.0, left: 10.0, top: 4.0),
                  width: 23,
                  height: 12,
                  child: Icon(Icons.star, color: Colors.yellow, size: 19.0)
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                    color: Color(0xFF969696),
                    width: 1.0,
                   )
                  ),
                  margin: EdgeInsets.only(right: 9.0, left: 120, top: 1.0),
                  width: 12,
                  height: 23,
                  child: Column(
                    children: <Widget> [
                      Icon(Icons.battery_full, color: Colors.green, size: 10.0),
                      Icon(Icons.wifi, color: Colors.green, size: 10.0)
                    ]
                  ),
                ),
              ]
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: 125,
              height: 25,
              child: Container(
                decoration: BoxDecoration(
                color: Color(0xFFE5E5E5),
                border: Border(
                  bottom: BorderSide(color: Color(0xFF969696), width: 2.0),
                  left: BorderSide(color: Color(0xFF969696), width: 2.0),
                  right: BorderSide(color: Color(0xFF969696), width: 2.0),
                )
              ),
              child: Row(
                children: <Widget> [
                  Icon(Icons.photo_camera, color: Color(0xFF969696)),
                  Expanded(child: Text(
                    widget.name,
                    style: TextStyle(fontSize:11),
                    overflow: TextOverflow.ellipsis
                    )
                  ),
                  Icon(Icons.edit, color: Color(0xFF969696))
                ]
              )
              )
            )
          ]
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
                        Expanded(
                          child: Align(
                            child: Text(widget.readings.last.light.toStringAsFixed(2) + ' lm'),
                            alignment: Alignment.centerRight
                          )
                        ),
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
                        Expanded(
                          child: Align(
                            child: Text(widget.readings.last.moisture.toStringAsFixed(2)),
                            alignment: Alignment.centerRight
                          ),
                        ),
                      ],
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
                        Expanded(
                          child: Align(
                            child: Text(widget.readings.last.humidity.toStringAsFixed(2) + ' %'),
                            alignment: Alignment.centerRight
                          )
                        ),
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
                        Expanded(
                          child: Align(
                            child: Text(
                              globals.tempUseF ? widget.readings.last.temperature.toStringAsFixed(2) + ' °F'  
                              : ((widget.readings.last.temperature - 32) * (5/9)).toStringAsFixed(2) + ' °C'
                              ),
                            alignment: Alignment.centerRight
                          )
                        ),
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