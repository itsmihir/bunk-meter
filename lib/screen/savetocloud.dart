import 'dart:convert';

import 'package:bunkmeter/provider/auth.dart';
import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/provider/dstorage.dart';
import 'package:bunkmeter/provider/timetable.dart';
import 'package:bunkmeter/screen/authscreen.dart';
import 'package:bunkmeter/screen/days.dart';
import 'package:bunkmeter/widget/alert/alert_dialog.dart';
import 'package:bunkmeter/widget/copytextbutton.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import 'package:bunkmeter/screen/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveTimeTable extends StatefulWidget {
  static String routeName = '/save';

  @override
  _SaveTimeTableState createState() => _SaveTimeTableState();
}

class _SaveTimeTableState extends State<SaveTimeTable> {
  List<TimeTable> timeTable;
  bool isloading = false;
  var db = DBHelper();

  Widget Logined(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 17, 25, 17),
          child: Text(
            "You Can Also Share Your Time Table With \n Your Friends",
            style: TextStyle(fontFamily: 'Lato', fontSize: 17),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 17, 25, 17),
          child: Text(
            "Just Send Time table KEY To Your Friend and Ask Him/Her to Apply That KEY in Download Time Table Section",
            style: TextStyle(fontFamily: 'Lato', fontSize: 17),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 17, 25, 17),
          child: Text(
            "Don't Worry Your Bunk Count Will NOT be Shared",
            style:
                TextStyle(fontFamily: 'Lato', fontSize: 17, color: Colors.red),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: FlatButton(
            color: Colors.blue,
            child: Text('Save Time Table'),
            onPressed: () async {
              setState(() {
                isloading = true;
              });
              String fileName = randomAlphaNumeric(10);
              try {
                final prefs = await SharedPreferences.getInstance();
                if (prefs.containsKey('filekey')) {
                  final key = json.decode(prefs.getString('filekey'))
                      as Map<String, dynamic>;
                  await db.DeleteFromServer(key['key'] + '.json');
                }
                final key = json.encode({'key': fileName});
                prefs.setString('filekey', key);

                await db.SaveToJSONFile(fileName + '.json');
                setState(() {
                  isloading = false;
                });
                await showDialog(
                    context: context,
                    builder: (ctx) => CustomAlertDialog(
                        title: 'Saving Done!!',
                        message: 'Share Key With Your Friends!',
                        widget: CustomToolTip(
                          text: fileName,
                        )));
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ],
    );
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save To Cloud'),
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Auth>(
              builder: (ctx, auth, _) => auth.isAuth
                  ? Logined(context)
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResult) =>
                          authResult.connectionState == ConnectionState.waiting
                              ? CircularProgressIndicator()
                              : AuthScreen(from: 0),
                    ),
            ),
    );
  }
}
