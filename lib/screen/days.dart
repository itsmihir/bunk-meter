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
  static bool editMode = false;
  static List<TimeTable> timetable;

  static List<Subject> subject;
  static bool BunkEditMode = false;

  @override
  _DaysState createState() => _DaysState();
}

class _DaysState extends State<Days> {
  var today = new DateTime.now();

  var dbHelper = DBHelper();

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
                  icon: Days.editMode
                      ? Icon(
                          MdiIcons.contentSaveSettings,
                          color: Colors.white,
                          size: 30,
                        )
                      : Icon(
                          MdiIcons.pen,
                          color: Colors.white,
                        ),
                  onPressed: () async {
                    if (Days.editMode) {
                      //      print(Days.timetable[0].lec);
                      await dbHelper.updatett(Days.timetable);
                    }
                    setState(() {
                      Days.editMode = !Days.editMode;
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
                timetable: Days.timetable.firstWhere((tt) => tt.day == 'mon'),
                subject: Days.subject,
                id: 'mon',
              ),
              TimeTableScreen(
                timetable: Days.timetable.firstWhere((tt) => tt.day == 'tue'),
                subject: Days.subject,
                id: 'tue',
              ),
              TimeTableScreen(
                timetable: Days.timetable.firstWhere((tt) => tt.day == 'wed'),
                subject: Days.subject,
                id: 'wed',
              ),
              TimeTableScreen(
                timetable: Days.timetable.firstWhere((tt) => tt.day == 'thr'),
                subject: Days.subject,
                id: 'thr',
              ),
              TimeTableScreen(
                timetable: Days.timetable.firstWhere((tt) => tt.day == 'fri'),
                subject: Days.subject,
                id: 'fri',
              ),
            ],
          ),
          drawer: MyDrawer(),
          bottomSheet: Days.editMode ? BottomEdit(Days.subject) : null,
          floatingActionButton: !Days.editMode
              ? FloatingActionButton(
                  child: Days.BunkEditMode
                      ? Text(
                          'Done',
                          style: TextStyle(fontFamily: 'Lato'),
                        )
                      : Text(
                          'Bunks\n   +/-',
                          style: TextStyle(fontFamily: 'Lato'),
                        ),
                  onPressed: () {
                    if (Days.BunkEditMode)
                      for (int i = 0; i < Days.subject.length; i++)
                        dbHelper.update(Days.subject[i]);
                    setState(() {
                      Days.BunkEditMode = !Days.BunkEditMode;
                    });
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.getSubject(),
      builder: (ctx, sub) {
        if (sub.hasData) {
          Days.subject = sub.data;
          return FutureBuilder(
            future: dbHelper.gettimetable(),
            builder: (ctx, tt) {
              if (tt.hasData) {
                Days.timetable = tt.data;
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
