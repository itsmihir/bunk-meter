import 'package:bunkmeter/provider/auth.dart';
import 'package:bunkmeter/screen/addcourse.dart';
import 'package:bunkmeter/screen/authscreen.dart';
import 'package:bunkmeter/screen/days.dart';
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
                      home: auth.isAuth
                          ? Days()
                          : FutureBuilder(
                              future: auth.tryAutoLogin(),
                              builder: (ctx, authResult) =>
                                  authResult.connectionState ==
                                          ConnectionState.waiting
                                      ? CircularProgressIndicator()
                                      : AuthScreen(),
                            ),
                      routes: {
                        AuthScreen.routeName: (ctx) => AuthScreen(),
                        Days.routeName: (ctx) => Days(),
                        Courses.routeName: (ctx) => Courses(),
                      },
                    ))));
  }
}
