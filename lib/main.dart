import 'package:bunkmeter/provider/auth.dart';
import 'package:bunkmeter/screen/addnewsubject.dart';
import 'package:bunkmeter/screen/mycourse.dart';
import 'package:bunkmeter/screen/authscreen.dart';
import 'package:bunkmeter/screen/days.dart';
import 'package:bunkmeter/screen/notify.dart';
import 'package:bunkmeter/screen/savetocloud.dart';
import 'package:bunkmeter/screen/statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Auth())],
        child: MaterialApp(
            home: Consumer<Auth>(
                builder: (ctx, auth, _) => MaterialApp(
                      title: 'MyShop',
                      theme: ThemeData(
                        primaryColor: Colors.blue,
                        accentColor: Colors.blue[800],
                        fontFamily: 'Lato',
                      ),
                      home: Days(), //auth.isAuth? Days()
                      // : FutureBuilder(
                      //     future: auth.tryAutoLogin(),
                      //     builder: (ctx, authResult) =>
                      //         authResult.connectionState ==
                      //                 ConnectionState.waiting
                      //             ? CircularProgressIndicator()
                      //             : AuthScreen(),
                      //   ),
                      routes: {
                        AuthScreen.routeName: (ctx) => AuthScreen(),
                        Days.routeName: (ctx) => Days(),
                        Courses.routeName: (ctx) => Courses(),
                        AddSubject.routeName: (ctx) => AddSubject(),
                        StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
                        Notify.routeName: (ctx) => Notify(),
                        SaveTimeTable.routeName: (ctx) => SaveTimeTable(),
                      },
                    ))));
  }
}
