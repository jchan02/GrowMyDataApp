import 'package:flutter/material.dart';
import 'package:gmd_project/model/navigation_model.dart';
import 'package:gmd_project/homepage.dart';
import 'package:gmd_project/userpage.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey();
void main() => runApp(MaterialApp(home: GMDApp()));

class GMDApp extends StatelessWidget {
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
          Navigator(
            key: navKey,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case 'page1':
                  return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Userpage(),
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
          NavigationDrawer()
        ]
      )
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
                    if (selectedIndex != counter) {
                      setState(() {
                        selectedIndex = counter;
                      });
                      navKey.currentState.popUntil(ModalRoute.withName('/'));
                      navKey.currentState.pushNamed('page'+selectedIndex.toString());
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
           Icon(widget.icon, color: widget.isSelected ? Color(0xFF007F0E) : Color(0xFF969696), size: 40.0,),
            SizedBox(width: (widthAnim.value >= 125) ? 10 : 0),
            (widthAnim.value >= 125) ? Text(widget.title) : Container()
          ],
        )
      )
    );
  }
}