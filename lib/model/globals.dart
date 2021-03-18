import 'package:flutter/material.dart';

bool tempUseF = true;
int readRate = 10;
bool notifEnable = true;
double notifThreshold = 30;
bool darkMode = false;
var loading = ValueNotifier(false);
ThemeSettings themeNotif = ThemeSettings();

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