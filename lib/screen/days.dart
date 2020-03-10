import 'package:bunkmeter/screen/drawer.dart';
import 'package:bunkmeter/widget/timetable.dart';
import "package:flutter/material.dart";
import 'dart:core';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Days extends StatefulWidget {
  static const routeName = '/home';
  @override
  _DaysState createState() => _DaysState();
}

class _DaysState extends State<Days> {
  var today = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: ((today.weekday - 1) >= 5) ? 0 : today.weekday - 1,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bunk-Meter',
            style: TextStyle(fontFamily: 'OpenSans'),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  MdiIcons.pen,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Monday',
              ),
              Tab(
                text: 'Tuesday',
              ),
              Tab(
                text: 'Wednesday',
              ),
              Tab(
                text: 'Thrusday',
              ),
              Tab(
                text: 'Friday',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TimeTable(0),
            TimeTable(1),
            TimeTable(2),
            TimeTable(3),
            TimeTable(4),
          ],
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
