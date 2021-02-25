import 'package:flutter/material.dart';
import 'package:gmd_project/model/plant_model.dart';

class Plantpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 55.0),
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFF007F0E),
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
          columnSpacing: 30.0,
          columns: [
            DataColumn(
              label: Text('Name'),
              numeric: false,
              tooltip: 'Plant name'
            ),
            DataColumn(
              label: Text('ID'),
              numeric: true,
              tooltip: 'Plant probe ID'
            ),
            DataColumn(
              label: Text('Last Reading'),
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
                    ),
                  )
                ),
                DataCell(
                  Container(
                    width: 20,
                    child: Text(
                      plant.id,
                      overflow: TextOverflow.ellipsis
                    ),
                  )
                ),
                DataCell(
                  Container(
                    width: 100,
                    child: Text(
                      plant.readings.last.time,
                      overflow: TextOverflow.ellipsis
                    ),
                  )
                ),
              ]
            )
          ).toList()
        )
      )
    );
  }
}