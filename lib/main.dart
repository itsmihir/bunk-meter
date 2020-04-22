import 'package:bunkmeter/provider/auth.dart';
import 'package:bunkmeter/screen/addnewsubject.dart';
import 'package:bunkmeter/screen/downloadtimetable.dart';
import 'package:bunkmeter/screen/mycourse.dart';
import 'package:bunkmeter/screen/authscreen.dart';
import 'package:bunkmeter/screen/days.dart';
import 'package:bunkmeter/screen/notify.dart';
import 'package:bunkmeter/screen/savetocloud.dart';
import 'package:bunkmeter/screen/statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import './provider/database.dart';

void main() {
  // var db = new DBHelper();
  // WidgetsFlutterBinding.ensureInitialized();
  // Workmanager.initialize(db.callbackDispatcher, isInDebugMode: true);
  // Workmanager.registerOneOffTask("1", "simpleTask");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Auth())],
        child: MaterialApp(
            home: Consumer<Auth>(
                builder: (ctx, auth, _) => MaterialApp(
                      title: 'Bunk-Meter',
                      theme: ThemeData(
                        primaryColor: Colors.blue,
                        accentColor: Colors.blue[800],
                        fontFamily: 'Lato',
                      ),
                      home: auth.isAuth
                          ? Days()
                          : FutureBuilder(
                              future: auth.tryAutoLogin(),
                              builder: (ctx, authResult) =>
                                  authResult.connectionState ==
                                          ConnectionState.waiting
                                      ? CircularProgressIndicator()
                                      : Days(),
                            ),
                      routes: {
                        AuthScreen.routeName: (ctx) => AuthScreen(),
                        Days.routeName: (ctx) => Days(),
                        Courses.routeName: (ctx) => Courses(),
                        AddSubject.routeName: (ctx) => AddSubject(),
                        StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
                        Notify.routeName: (ctx) => Notify(),
                        SaveTimeTable.routeName: (ctx) => SaveTimeTable(),
                        Download.routeName: (ctx) => Download(),
                      },
                    ))));
  }
}
