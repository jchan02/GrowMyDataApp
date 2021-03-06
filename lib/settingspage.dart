import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    return Container(
      margin: EdgeInsets.only(left: 55, top: 16),
      child: (globals.email == '') ? Center(child: Text('Sign in to change your settings', style: TextStyle(color: Theme.of(context).hintColor)))
      : ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          Column(
            children: <Widget> [
              Text('Delay between plant readings', style: TextStyle(color: Theme.of(context).hintColor)),
              Text('(applies to newly registered plants)', style: TextStyle(color: Theme.of(context).hintColor)),
              Container(
                color: Colors.white,
                height: 40,
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  value: selectedRate,
                  items: rateMenuItems,
                  onChanged: (RateMenuItem selectedItem) {
                    setState(() {
                      selectedRate = selectedItem;
                      globals.readRate = selectedItem.rateMinutes;
                    });
                  }
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              SizedBox(height: 16),
              Text('Units for temperature measurement', style: TextStyle(color: Theme.of(context).hintColor)),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('°C', style: TextStyle(color: Theme.of(context).hintColor)),
                    Switch(
                      value: tempUseF,
                      activeColor: Theme.of(context).primaryColor,
                      activeTrackColor: Theme.of(context).accentColor,
                      inactiveThumbColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: Theme.of(context).accentColor,
                      onChanged: (value) {
                        setState(() {
                          tempUseF = !tempUseF;
                          globals.tempUseF = tempUseF;
                        });
                      },
                    ),
                    Text('°F', style: TextStyle(color: Theme.of(context).hintColor))
                  ]
                )
              ),
              SizedBox(height: 16),
            ],
          ),
          Column(
            children: <Widget> [
              SizedBox(height: 16),
              Text('Enable push notifications', style: TextStyle(color: Theme.of(context).hintColor)),
              Text('(Current = ' + globals.notifEnable.toString() + ')', style: TextStyle(color: Theme.of(context).hintColor)),
              Switch(
                value: notifEnable,
                activeColor: Theme.of(context).primaryColor,
                activeTrackColor: Theme.of(context).accentColor,
                inactiveTrackColor: Theme.of(context).buttonColor,
                onChanged: (value) {
                  setState(() {
                    notifEnable = !notifEnable;
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Reading quality level to trigger notification', style: TextStyle(color: Theme.of(context).hintColor)),
              Text('(Current = ' + (globals.notifThreshold).round().toString() + '%)', style: TextStyle(color: Theme.of(context).hintColor)),
              Slider(
                value: notifThreshold,
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Theme.of(context).accentColor,
                label: notifThreshold.round().toString(),
                onChanged: (double value) {
                  setState (() {
                    notifThreshold = value;
                  });
                }
              ),
              SizedBox(height: 16),
            ]
          ),
          Column(
            children: <Widget> [
              SizedBox(height: 16),
              Text('Enable dark mode', style: TextStyle(color: Theme.of(context).hintColor)),
              Switch(
                value: darkMode,
                activeColor: Theme.of(context).primaryColor,
                activeTrackColor: Theme.of(context).accentColor,
                inactiveTrackColor: Theme.of(context).buttonColor,
                onChanged: (value) {
                  setState(() {
                    darkMode = !darkMode;
                    globals.darkMode = darkMode;
                    globals.themeNotif.switchTheme();
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
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                ),
                onPressed: () {

                },
                child: Text('Request Readings File', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
              ),
              SizedBox(height: 16),
            ]
          ),
          Column(
            children: <Widget> [
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                ),
                onPressed: () {
                  setState((){
                    globals.loading.value = true;
                    globals.notifEnable = notifEnable;
                    globals.notifThreshold = notifThreshold;
                    updateSettings(globals.email, notifEnable, notifThreshold).then((String result){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: (result == 'Settings changed successfully') ? Theme.of(context).primaryColor : Colors.red,
                          content: Container(
                            child:  Text(result, style: TextStyle(color: Theme.of(context).secondaryHeaderColor)
                            )
                          )
                        )
                      );
                      globals.loading.value = false;
                    });
                  });
                },
                child: Text('Save Changes', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
              ),
              SizedBox(height: 16),
            ]
          ),
        ]
      ).toList()
    ));
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
        child: Text(item.rateText, style: TextStyle(color: Colors.black))
      )
    );
  }
  return rateMenu;
}

Future<String> updateSettings(String email, bool enable, double threshold) async{
  String theUrl = "https://71142021.000webhostapp.com/updateSettings.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'email':email, 'notifEnable':enable ? '1' : '0', 'notifThreshold':(threshold/100).toString()});
  var respBody = res.body;
  return respBody;
}