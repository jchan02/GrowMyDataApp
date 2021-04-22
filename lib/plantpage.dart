import 'package:flutter/material.dart';
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;
import 'package:http/http.dart' as http;

class Plantpage extends StatefulWidget {
  @override
  _PlantpageState createState() => _PlantpageState();
}

class _PlantpageState extends State<Plantpage> {
  String test = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 55.0),
      child: (globals.email == '') ? Center(child: Text((plantProbes.length == 0 && globals.email != '') ? 'No plants have been registered' : 'Sign in to view your plants', style: TextStyle(color: Theme.of(context).hintColor)))
      :Stack(
        children: <Widget> [
          Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).accentColor,
              child: Icon(Icons.add, color: Colors.white, size: 30),
              onPressed: (() => {
                addPlant().then((String result){setState((){test = result.toString();});}),
                plantProbes.add(PlantModel(
                id: int.parse(test), name: 'New Plant', favorite: false, readings: []
                )),
              })
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Text(
                    (plantProbes.length != 1) ? plantProbes.length.toString()+' plants registered' : '1 plant registered',
                    style: TextStyle(
                      color: Colors.white
                    )
                  )
                ]
              )
            ),
            body: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 30.0,
              columns: [
                DataColumn(
                  label: Text('Name', style: TextStyle(color: Theme.of(context).hintColor)),
                  numeric: false,
                  tooltip: 'Plant name'
                ),
                DataColumn(
                  label: Text('ID', style: TextStyle(color: Theme.of(context).hintColor)),
                  numeric: true,
                  tooltip: 'Plant probe ID'
                ),
                DataColumn(
                  label: Text('Last Reading', style: TextStyle(color: Theme.of(context).hintColor)),
                  numeric: false,
                  tooltip: 'Time of most recent reading'
                ),
              ],
              rows: plantProbes.map(
                (plant) => DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 80,
                        child: Text(
                          plant.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).hintColor)
                        ),
                      )
                    ),
                    DataCell(
                      Container(
                        width: 20,
                        child: Text(
                          plant.id.toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).hintColor)
                        ),
                      )
                    ),
                    DataCell(
                      Container(
                        width: 100,
                        child: (plant.readings.length > 0) ? Text(
                          globals.monthName[plant.readings.last.time.month-1] + ' ' + plant.readings.last.time.day.toString() + ', ' + plant.readings.last.time.year.toString() +
                          '\n' + globals.timeDisplay(plant.readings.last.time),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).hintColor)
                        ) : Text(
                          'No readings',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).hintColor)
                          )
                      )
                    ),
                  ],
                  onSelectChanged: (bool selected) {
                    if(selected && plant.readings.length > 0) {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => AlertDialog(
                          title: Text('Readings for ' + plant.name, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).hintColor), overflow: TextOverflow.ellipsis,),
                          elevation: 0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          content: Container(
                            child: DataTable(
                              columnSpacing: 0.0,
                              columns: [
                                DataColumn(
                                  label: Text('Time', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10)),
                                  numeric: false,
                                  tooltip: 'Time of reading'
                                ),
                                DataColumn(
                                  label: Text('Light\n(lux)', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10)),
                                  numeric: false,
                                  tooltip: 'Sunlight illuminance'
                                ),
                                DataColumn(
                                  label: Text('Moisture\n(%)', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10)),
                                  numeric: false,
                                  tooltip: 'Moisture'
                                ),
                                DataColumn(
                                  label: Text('Humidity\n(%)', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10)),
                                  numeric: false,
                                  tooltip: 'Humidity'
                                ),
                                DataColumn(
                                  label: Text(globals.tempUseF ? 'Temp\n(°F)' : 'Temp\n(°C)', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10)),
                                  numeric: false,
                                  tooltip: 'Temperature'
                                ),
                              ],
                              rows: <DataRow>[
                                ...plant.readings.map(
                                  (reading) => DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: 60,
                                          child: Text(
                                            globals.monthName[reading.time.month-1] + ' ' + reading.time.day.toString() + ', ' + reading.time.year.toString() +
                                            '\n' + globals.timeDisplay(plant.readings.last.time),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10),
                                          )
                                        )
                                      ),
                                      DataCell(
                                        Container(
                                          width: 50,
                                          child: Text(
                                            reading.light.toStringAsFixed(2),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10),
                                          )
                                        )
                                      ),
                                      DataCell(
                                        Container(
                                          width: 30,
                                          child: Text(
                                            reading.moisture.toStringAsFixed(2),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10),
                                          )
                                        )
                                      ),
                                      DataCell(
                                        Container(
                                          width: 30,
                                          child: Text(
                                            reading.humidity.toStringAsFixed(2),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10),
                                          )
                                        )
                                      ),
                                      DataCell(
                                        Container(
                                          width: 30,
                                          child: Text(
                                            globals.tempUseF ? reading.temperature.toStringAsFixed(2) : ((reading.temperature - 32) * 5/9).toStringAsFixed(2),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10),
                                          )
                                        )
                                      ),
                                    ]
                                  )
                                )
                              ],
                            )
                          ),
                        )
                      );
                    }
                  }
                )
              ).toList()
            )
          ),
        ]
      )
    );
  }
}

Future<String> addPlant() async{
  String theUrl = "https://71142021.000webhostapp.com/setUserPlant.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'email': 'abc123@gmail.com','plantName': 'New Plant',});
  var respBody = res.body;
  return respBody;
}