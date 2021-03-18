import 'package:flutter/material.dart';
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future homeRefresh() async{
    setState(() => globals.loading.value = true);
    await Future.delayed(Duration(milliseconds: 500));
    globals.loading.value = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 3.0,
      child: RefreshIndicator(
        color: Theme.of(context).primaryColor,
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
        ),
        onRefresh: homeRefresh,
        displacement: 0,
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
                    color: Theme.of(context).backgroundColor,
                    border: Border.all(
                    color: Theme.of(context).buttonColor,
                    width: 2.0,
                   )
                  ),
                  margin: EdgeInsets.only(right: 8.0, left: 8.0),
                  width: 125,
                  height: 100,
                  child: Center(child: Icon(Icons.image_not_supported, color: Theme.of(context).cardColor, size: 90.0)),
                ),
                Container(
                  margin: EdgeInsets.only(right: 9.0, left: 9.0, top: 1.0),
                  width: 23,
                  height: 12,
                  child: Icon(Icons.star, color: Theme.of(context).buttonColor, size: 25.0)
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
                    color: Theme.of(context).buttonColor,
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
                color: Theme.of(context).backgroundColor,
                border: Border(
                  bottom: BorderSide(color: Theme.of(context).buttonColor, width: 2.0),
                  left: BorderSide(color: Theme.of(context).buttonColor, width: 2.0),
                  right: BorderSide(color: Theme.of(context).buttonColor, width: 2.0),
                )
              ),
              child: Row(
                children: <Widget> [
                  Icon(Icons.photo_camera, color: Theme.of(context).buttonColor),
                  Expanded(child: Text(
                    widget.name,
                    style: TextStyle(fontSize:11, color: Theme.of(context).hintColor),
                    overflow: TextOverflow.ellipsis
                    )
                  ),
                  Icon(Icons.edit, color: Theme.of(context).buttonColor)
                ]
              )
              )
            )
          ]
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                color: Theme.of(context).buttonColor,
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
                          color: Theme.of(context).buttonColor,
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
                            child: Text(widget.readings.last.light.toStringAsFixed(2) + ' lux'),
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
                          color: Theme.of(context).buttonColor,
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
                            child: Text(widget.readings.last.moisture.toStringAsFixed(2) + ' %'),
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
                          color: Theme.of(context).buttonColor,
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