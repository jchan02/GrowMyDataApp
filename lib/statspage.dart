import 'package:flutter/material.dart';

class Statspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 55.0),
      child: Text('Stats page', style: TextStyle(color: Theme.of(context).hintColor))
    );
  }
}