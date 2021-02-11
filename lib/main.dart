import 'package:flutter/material.dart';
import 'package:gmd_project/model/navigation_model.dart';
import 'package:gmd_project/model/plant_model.dart';

void main() => runApp(GMDApp());

class GMDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowMyData App',
      home: GMDFrame(),
    );
  }
}

class GMDFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF007F0E),
        title: Center(
          child: Text("GrowMyData")
        ),
      ),
      body: Stack(
        children: <Widget> [
          Homepage(),
          NavigationDrawer(),
        ],
      )
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> with SingleTickerProviderStateMixin{
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
        color: Color(0xFFE5E5E5),
        border: Border(
          right: BorderSide(
            color: Color(0xFF969696),
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
              color: Color(0xFF969696),
              size: 40.0,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, counter) {
                return CollapsingListTile(
                  isSelected: selectedIndex == counter,
                  onTap: () {
                    setState(() {
                      selectedIndex = counter;
                    });
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
           Icon(widget.icon, color: widget.isSelected ? Color(0xFF007F0E) : Color(0xFF969696), size: 40.0,),
            SizedBox(width: (widthAnim.value >= 125) ? 10 : 0),
            (widthAnim.value >= 125) ? Text(widget.title) : Container()
          ],
        )
      )
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 56.0),
      itemBuilder: (context, counter) {
        return HomePlantView(
          id: plantProbes[counter].id,
          name: plantProbes[counter].name,
          readings: plantProbes[counter].readings,
        );
      },
      itemCount: plantProbes.length,
    );
  }
}

class HomePlantView extends StatefulWidget {
  final String id;
  final String name;
  final List<PlantReading> readings;
  HomePlantView({this.id, this.name, this.readings});
  @override
  _HomePlantViewState createState() => _HomePlantViewState();
}

class _HomePlantViewState extends State<HomePlantView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        Container(
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
          child: Center(child: Text(widget.name)),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E5E5),
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
                        Expanded(child: Align(child: Text(widget.readings.last.light.toString()), alignment: Alignment.centerRight)),
                      ]
                    )
                  )
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E5E5),
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
                        Expanded(child: Align(child: Text(widget.readings.last.moisture.toString()), alignment: Alignment.centerRight)),
                      ]
                    )
                  )
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E5E5),
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
                        Expanded(child: Align(child: Text(widget.readings.last.humidity.toString()), alignment: Alignment.centerRight)),
                      ]
                    )
                  )
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Row(
                      children: <Widget> [
                        Icon(
                          Icons.thermostat_rounded,
                          color: Colors.black,
                        ),
                        Expanded(child: Align(child: Text(widget.readings.last.temperature.toString()), alignment: Alignment.centerRight)),
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