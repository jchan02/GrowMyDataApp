import 'package:flutter/material.dart';
import 'package:gmd_project/model/navigation_model.dart';
import 'package:gmd_project/model/plant_model.dart';
import 'package:gmd_project/model/globals.dart' as globals;
import 'package:gmd_project/homepage.dart';
import 'package:gmd_project/userpage.dart';
import 'package:gmd_project/plantpage.dart';
import 'package:gmd_project/statspage.dart';
import 'package:gmd_project/settingspage.dart';

GlobalKey<NavigatorState> navKey = GlobalKey();
void main() => runApp(GMDApp());

class GMDApp extends StatefulWidget {
  @override
  _GMDAppState createState() => _GMDAppState();
}

class _GMDAppState extends State<GMDApp> {
  @override
  void initState() {
    super.initState();
    globals.themeNotif.addListener(() {setState((){});});
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Overview(),
      theme: ThemeData(
        primaryColor: Color(0xFF007F0E),
        accentColor: Colors.green[100],
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Color(0xFFE5E5E5),
        buttonColor: Color(0xFF969696),
        cardColor: Color(0xFFBFBFBF),
        hintColor: Colors.black,
        secondaryHeaderColor: Colors.white
      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xFF007F0E),
        accentColor: Colors.green[100],
        scaffoldBackgroundColor: Color(0xFF1E1E1E),
        backgroundColor: Color(0xFF262626),
        buttonColor: Color(0xFF4C4C4C),
        cardColor: Color(0xFFBFBFBF),
        hintColor: Colors.white,
        secondaryHeaderColor: Colors.black
      ),
      themeMode: globals.themeNotif.currentTheme()
    );
  }
}

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text("GrowMyData", style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Temp Test'),
        onPressed: (() => plantProbes[0].readings.add(PlantReading(
          time: "1", light: 1, lightQuality: 1, moisture: 1, moistureQuality: 1,
          humidity: 1, humidityQuality: 1, temperature: 1, temperatureQuality: 1,
        )))
      ),
      body: Stack(
        children: <Widget> [
          Navigator(
            key: navKey,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case 'page1':
                  return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Userpage(),
                    transitionDuration: Duration(seconds: 0),
                  );
                case 'page2':
                  return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Plantpage(),
                    transitionDuration: Duration(seconds: 0),
                  );
                case 'page3':
                  return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Statspage(),
                    transitionDuration: Duration(seconds: 0),
                  );
                case 'page5':
                  return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Settingspage(),
                    transitionDuration: Duration(seconds: 0),
                  );
                default:
                  return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Homepage(),
                    transitionDuration: Duration(seconds: 0),
                  );
              }
            }
          ),
          NavigationDrawer(),
          ValueListenableBuilder(
            valueListenable: globals.loading,
            builder: (context, value, child) {
              if(globals.loading.value) return globals.Loader();
              return Container();
            }
          )
        ]
      )
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> with SingleTickerProviderStateMixin{
  void pageNav(context) async{
    globals.loading.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    navKey.currentState.pushNamed('page'+selectedIndex.toString());
    globals.loading.value = false;
  }
  bool isCollapsed = false;
  int selectedIndex = 0;
  AnimationController _animationController;
  Animation<double> widthAnim;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnim = Tween<double>(begin: 55, end: 200).animate(_animationController);
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController, 
      builder: (context, widget) => getWidget(context, widget),
    );
  }
  Widget getWidget(context, widget) {
    return Container(
      width: widthAnim.value,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).buttonColor,
            width: 2.0,
          )
        )
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          InkWell(
            onTap: () {
              setState(() {
                isCollapsed = !isCollapsed;
                isCollapsed ? _animationController.forward() : _animationController.reverse();
              });
            },
            child: Icon(
              Icons.menu,
              color: Theme.of(context).buttonColor,
              size: 40.0,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, counter) {
                return CollapsingListTile(
                  isSelected: selectedIndex == counter,
                  onTap: () {
                    if (selectedIndex != counter) {
                      setState(() {
                        selectedIndex = counter;
                        navKey.currentState.popUntil(ModalRoute.withName('/'));
                      }); 
                      pageNav(context);
                    }
                  },
                  title: navItems[counter].title,
                  icon: navItems[counter].icon,
                  animationController: _animationController
                );
              },
              itemCount: navItems.length,
            )
          ),
        ]
      )
    );
  }
}

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Function onTap;
  final AnimationController animationController;
  CollapsingListTile({@required this.title, @required this.icon, @required this.animationController, this.isSelected = false, this.onTap});
  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> widthAnim;
  @override
  void initState() {
    super.initState();
    widthAnim = Tween<double>(begin: 56, end: 200).animate(widget.animationController);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected ? Colors.transparent.withOpacity(0.15) : Colors.transparent,
        ),
        width: widthAnim.value,
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
           Icon(widget.icon, color: widget.isSelected ? Theme.of(context).primaryColor : Theme.of(context).buttonColor, size: 40.0,),
            SizedBox(width: (widthAnim.value >= 125) ? 10 : 0),
            (widthAnim.value >= 125) ? Text(widget.title, style: TextStyle(color: Theme.of(context).hintColor)) : Container()
          ],
        )
      )
    );
  }
}