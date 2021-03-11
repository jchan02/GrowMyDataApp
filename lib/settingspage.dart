import 'package:flutter/material.dart';
import 'package:gmd_project/model/globals.dart' as globals;

class Settingspage extends StatefulWidget {
  @override
  _SettingspageState createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  List<RateMenuItem> rateMenu = RateMenuItem.getMenu();
  List<DropdownMenuItem<RateMenuItem>> rateMenuItems;
  RateMenuItem selectedRate;
  bool tempUseF = globals.tempUseF;
  bool notifEnable = globals.notifEnable;
  double notifThreshold = globals.notifThreshold;
  bool darkMode = globals.darkMode;
  @override
  void initState() {
    rateMenuItems = buildRateMenu(rateMenu);
    selectedRate = rateMenuItems[0].value;
    super.initState();
  }
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 55.0, top: 16),
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          Column(
            children: <Widget> [
              Text('Delay between plant readings'),
              Text('(applies after next reading)'),
              DropdownButton(
                value: selectedRate,
                items: rateMenuItems,
                onChanged: (RateMenuItem selectedItem) {
                  setState(() {
                    selectedRate = selectedItem;
                    globals.readRate = selectedItem.rateMinutes;
                  });
                }
              ),
              SizedBox(height: 16),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              SizedBox(height: 16),
              Text('Units for temperature measurement'),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('°C'),
                    Switch(
                      value: tempUseF,
                      activeColor: Color(0xFF007F0E),
                      activeTrackColor: Colors.green[100],
                      inactiveThumbColor: Color(0xFF007F0E),
                      inactiveTrackColor: Colors.green[100],
                      onChanged: (value) {
                        setState(() {
                          tempUseF = !tempUseF;
                          globals.tempUseF = tempUseF;
                        });
                      },
                    ),
                    Text('°F')
                  ]
                )
              ),
              SizedBox(height: 16),
            ],
          ),
          Column(
            children: <Widget> [
              SizedBox(height: 16),
              Text('Enable push notifications'),
              Switch(
                value: notifEnable,
                activeColor: Color(0xFF007F0E),
                activeTrackColor: Colors.green[100],
                onChanged: (value) {
                  setState(() {
                    notifEnable = !notifEnable;
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Reading quality level to trigger notification'),
              Slider(
                value: notifThreshold,
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: Color(0xFF007F0E),
                inactiveColor: Colors.green[100],
                label: notifThreshold.round().toString(),
                onChanged: (double value) {
                  setState (() {
                    notifThreshold = value;
                    globals.notifThreshold = value;
                  });
                }
              ),
              SizedBox(height: 16),
            ]
          ),
          Column(
            children: <Widget> [
              SizedBox(height: 16),
              Text('Enable dark mode'),
              Switch(
                value: darkMode,
                activeColor: Color(0xFF007F0E),
                activeTrackColor: Colors.green[100],
                onChanged: (value) {
                  setState(() {
                    darkMode = !darkMode;
                    globals.darkMode = darkMode;
                  });
                },
              ),
              SizedBox(height: 16),
            ]
          ),
          Column(
            children: <Widget> [
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF007F0E))
                ),
                onPressed: () {

                },
                child: Text('Request Readings File')
              ),
              SizedBox(height: 16),
            ]
          ),
          Column(
            children: <Widget> [
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF007F0E))
                ),
                onPressed: () {

                },
                child: Text('Save Changes')
              ),
              SizedBox(height: 16),
            ]
          ),
        ]
      ).toList()
    );
  }
}

class RateMenuItem {
  int rateMinutes;
  String rateText;
  RateMenuItem(this.rateMinutes, this.rateText);
  static List<RateMenuItem> getMenu() {
    return <RateMenuItem> [
      RateMenuItem(10, '10 minutes'),
      RateMenuItem(20, '20 minutes'),
      RateMenuItem(30, '30 minutes'),
      RateMenuItem(40, '40 minutes'),
      RateMenuItem(50, '50 minutes'),
      RateMenuItem(60, '1 hour'),
      RateMenuItem(120, '2 hours'),
      RateMenuItem(240, '4 hours'),
      RateMenuItem(480, '8 hours'),
      RateMenuItem(720, '12 hours'),
      RateMenuItem(1440, '24 hours'),
    ];
  }
}

List<DropdownMenuItem<RateMenuItem>> buildRateMenu(List items){
  List<DropdownMenuItem<RateMenuItem>> rateMenu = [];
  for(RateMenuItem item in items){
    rateMenu.add(
      DropdownMenuItem(
        value: item,
        child: Text(item.rateText)
      )
    );
  }
  return rateMenu;
}