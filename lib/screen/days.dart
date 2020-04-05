import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/provider/subject.dart';
import 'package:bunkmeter/provider/timetable.dart';
import 'package:bunkmeter/screen/drawer.dart';
import 'package:bunkmeter/screen/timetable.dart';
import 'package:bunkmeter/widget/bottomedit.dart';
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

  List<Subject> subject;
  List<TimeTable> timetable;
  var dbHelper = DBHelper();

  bool editMode = false;

  Widget TabWidget() {
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
                  icon: editMode
                      ? Icon(
                          MdiIcons.contentSaveSettings,
                          color: Colors.white,
                          size: 30,
                        )
                      : Icon(
                          MdiIcons.pen,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    setState(() {
                      editMode = !editMode;
                    });
                  })
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
              TimeTableScreen(
                timetable: timetable.firstWhere((tt) => tt.day == 'mon'),
                subject: subject,
              ),
              TimeTableScreen(
                timetable: timetable.firstWhere((tt) => tt.day == 'tue'),
                subject: subject,
              ),
              TimeTableScreen(
                timetable: timetable.firstWhere((tt) => tt.day == 'wed'),
                subject: subject,
              ),
              TimeTableScreen(
                timetable: timetable.firstWhere((tt) => tt.day == 'thr'),
                subject: subject,
              ),
              TimeTableScreen(
                timetable: timetable.firstWhere((tt) => tt.day == 'fri'),
                subject: subject,
              ),
            ],
          ),
          drawer: MyDrawer(),
          bottomSheet: editMode ? BottomEdit(subject) : null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.getSubject(),
      builder: (ctx, sub) {
        if (sub.hasData) {
          subject = sub.data;
          return FutureBuilder(
            future: dbHelper.gettimetable(),
            builder: (ctx, tt) {
              if (tt.hasData) {
                timetable = tt.data;
                return TabWidget();
              }
              return Center(child: CircularProgressIndicator());
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
