import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Courses extends StatelessWidget {
  static String routeName = '/courses';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Courses',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(MdiIcons.plus), onPressed: () {})
        ],
      ),
      body: Container(),
    );
  }
}
