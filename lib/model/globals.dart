import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
String email = '';
bool tempUseF = true;
int readRate = 10;
bool notifEnable = true;
double notifThreshold = 0.3;
bool darkMode = false;
var loading = ValueNotifier(false);
ThemeSettings themeNotif = ThemeSettings();
final List<String> monthName = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

Future<String> getData() async{
  var url = 'https://71142021.000webhostapp.com/get.php';
  http.Response response = await http.get(url);
  var data = response.body;
  return data.toString();
}

String timeDisplay(DateTime t) {
  int hour;
  String ampm;
  if (t.hour == 0) {hour = 12; ampm = ' AM';}
  else if (t.hour == 12) {hour = 12; ampm = ' PM';}
  else if (t.hour > 12) {hour = t.hour - 12; ampm = ' PM';}
  else {hour = t.hour; ampm = ' AM';}
  return hour.toString() + ':' + (t.minute < 10 ? '0':'') + t.minute.toString() + ampm;
}

class ThemeSettings with ChangeNotifier{
  ThemeMode currentTheme() {
    return darkMode ? ThemeMode.dark : ThemeMode.light;
  }
  void switchTheme() {
    notifyListeners();
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5)
      ),
      child: Center(
        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF007F0E)))
      )
    );
  }
}