import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notify extends StatefulWidget {
  static const routeName = '/notify';
  @override
  _NotifyState createState() => new _NotifyState();
}

class _NotifyState extends State<Notify> {
  bool _isset = false;
  bool _isloading = true;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future onSelectNotification(String payload) async {}
  final format = DateFormat("HH:mm");

  Future _showNotificationWithDefaultSound(Time time) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    // var time = Time(1, 46, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Please Update Today\'s Bunks',
        'We want to know how many lectures you have BUNKED today',
        time,
        platformChannelSpecifics);
  }

  SharedPreferences prefs;
  @override
  initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      prefs = p;
      int notify = prefs.getInt('notify');

      print('Pressed $notify times.');
      if (notify == 1) {
        setState(() {
          _isset = true;
          _isloading = false;
        });
      }
      setState(() {
        _isloading = false;
      });
    });
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Notification'),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                Text(
                  'We Will Remind You To Update Bunk Count Please Select Suitable You Want To Get Notify',
                  style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
                ),
                SizedBox(
                  height: 60,
                ),
                _isset
                    ? Column(
                        children: <Widget>[
                          DateTimeField(
                            initialValue: null,
                            decoration:
                                new InputDecoration(hintText: 'Click me'),
                            cursorColor: Colors.blue,
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              Time t = Time(time.hour, time.minute, 0);

                              await flutterLocalNotificationsPlugin
                                  .cancelAll()
                                  .then((e) {
                                print('here');
                                _showNotificationWithDefaultSound(t);
                              });
                              return DateTimeField.convert(time);
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          FlatButton(
                            child: Text('Turn Off Notification'),
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              setState(() {
                                _isset = false;
                              });
                              await prefs.setInt('notify', 0);
                              await flutterLocalNotificationsPlugin.cancelAll();
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: FlatButton(
                          child: Text('Turn On Notification'),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            setState(() {
                              _isset = true;
                            });
                            await prefs.setInt('notify', 1);
                          },
                        ),
                      ),
              ])),
    );
  }
}
