import 'package:flutter/material.dart';
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future homeRefresh() async{
    setState(() => globals.loading.value = true);
    if(globals.email != '') getUserPlants(globals.email).then((String result){
      if(result.contains('[{')) plantProbes = (jsonDecode(result) as List).map((i) => PlantModel.fromJson(i)).toList();
      plantProbes.forEach((item){
        getPlantTraits(item.id).then((String result){
            if(result.contains('[{')) item.readings = (jsonDecode(result) as List).map((i) => PlantReading.fromJson(i)).toList();
        });
      });
    });
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() => globals.loading.value = false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: (globals.email == '') ? 55 : 0),
      child: (globals.email == '') ? Center(child: Text((plantProbes.length == 0 && globals.email != '') ? 'No plants have been registered' : 'Sign in to view your plants', style: TextStyle(color: Theme.of(context).hintColor)))
      : Scrollbar(
        thickness: 3.0,
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 56.0),
            itemBuilder: (context, counter) {
              return HomePlantView(
                index: counter,
                id: plantProbes[counter].id.toString(),
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
      )
    );
  }
}
//ignore: must_be_immutable
class HomePlantView extends StatefulWidget {
  int index;
  String id;
  String name;
  bool favorite;
  List<PlantReading> readings;
  HomePlantView({this.index, this.id, this.name, this.favorite, this.readings});
  @override
  _HomePlantViewState createState() => _HomePlantViewState();
}

class _HomePlantViewState extends State<HomePlantView> {
  final renameKey = GlobalKey<FormState>();
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
                  InkWell(
                    child: Icon(Icons.edit, color: Theme.of(context).buttonColor),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                          title: Text('Enter a new name for \n${widget.name}', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).hintColor),),
                          elevation: 0,
                          backgroundColor: Theme.of(context).backgroundColor,
                          content: Container(
                            child: Form(
                              key: renameKey,
                              child: TextFormField(
                                style: TextStyle(color: Theme.of(context).hintColor),
                                onSaved: (input) => {
                                  setState(() => globals.loading.value = true),
                                  plantProbes[widget.index].name = input,
                                  widget.name = input,
                                  updatePlantName(input, widget.id.toString()).then((String result){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Theme.of(context).primaryColor,
                                        content: Container(
                                          child: Text(result, style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                                        )
                                      )
                                    );
                                    setState(() => globals.loading.value = false);
                                  }),
                                },
                                validator: (value) {
                                  if (value.isEmpty){
                                    return 'Please enter a new name';
                                  }
                                  return null;
                                },
                                initialValue: widget.name,
                                decoration: InputDecoration(
                                  hintText: '',
                                ),
                              )
                            )
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              }
                            ),
                            TextButton(
                              child: Text('Confirm', style: TextStyle(color: Theme.of(context).primaryColor)),
                              onPressed: () {
                                if(renameKey.currentState.validate()){
                                  renameKey.currentState.save();
                                  Navigator.of(context, rootNavigator: true).pop();
                                }
                              }
                            ) ,
                          ],
                        )
                      );
                    }
                  )
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
                      color: (widget.readings.length > 0) ? (widget.readings.last.lightQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.lightQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.lightQuality)).round(), 0) : Theme.of(context).backgroundColor,
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
                          color: (widget.readings.length > 0) ? Colors.black : Theme.of(context).hintColor
                        ),
                        Expanded(
                          child: Align(
                            child: (widget.readings.length > 0) ? Text(widget.readings.last.light.toStringAsFixed(2) + ' lux') :
                              Text('No readings', style: TextStyle(color: Theme.of(context).hintColor)),
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
                      color: (widget.readings.length > 0) ? (widget.readings.last.moistureQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.moistureQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.moistureQuality)).round(), 0) : Theme.of(context).backgroundColor,
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
                          color: (widget.readings.length > 0) ? Colors.black : Theme.of(context).hintColor
                        ),
                        Expanded(
                          child: Align(
                            child: (widget.readings.length > 0) ? Text(widget.readings.last.moisture.toStringAsFixed(2) + ' %') :
                              Text('No readings', style: TextStyle(color: Theme.of(context).hintColor)),
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
                      color: (widget.readings.length > 0) ? (widget.readings.last.humidityQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.humidityQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.humidityQuality)).round(), 0) : Theme.of(context).backgroundColor,
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
                          color: (widget.readings.length > 0) ? Colors.black : Theme.of(context).hintColor
                        ),
                        Expanded(
                          child: Align(
                            child: (widget.readings.length > 0) ? Text(widget.readings.last.humidity.toStringAsFixed(2) + ' %') :
                              Text('No readings', style: TextStyle(color: Theme.of(context).hintColor)),
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
                      color: (widget.readings.length > 0) ? (widget.readings.last.temperatureQuality >= 0.5) ? 
                        Color.fromARGB(255, (255*(2-2*widget.readings.last.temperatureQuality)).round(), 255, 0) :
                        Color.fromARGB(255, 255, (255*(2*widget.readings.last.temperatureQuality)).round(), 0) : Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      children: <Widget> [
                        Icon(
                          Icons.thermostat_rounded,
                          color: (widget.readings.length > 0) ? Colors.black : Theme.of(context).hintColor
                        ),
                        Expanded(
                          child: Align(
                            child: (widget.readings.length > 0) ? Text(
                              globals.tempUseF ? widget.readings.last.temperature.toStringAsFixed(2) + ' °F'  
                              : ((widget.readings.last.temperature - 32) * (5/9)).toStringAsFixed(2) + ' °C'
                              ) : Text('No readings', style: TextStyle(color: Theme.of(context).hintColor)),
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

Future<String> getUserPlants(String email) async{
  var url = 'https://71142021.000webhostapp.com/getUserPlants.php';
  String queryString = Uri(queryParameters: {'emailAddress':email}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> getPlantTraits(int id) async{
  var url = 'https://71142021.000webhostapp.com/getPlantTraits.php';
  String queryString = Uri(queryParameters: {'plantID':id.toString()}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> updatePlantName(String name, String id) async{
  String theUrl = "https://71142021.000webhostapp.com/updatePlantName.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'plantName': name, 'plantId': id});
  var respBody = res.body;
  return respBody;
}