import 'package:bunkmeter/models/enum.dart';
import 'package:bunkmeter/provider/auth.dart';
import 'package:bunkmeter/screen/authscreen.dart';
import 'package:bunkmeter/screen/downloadtimetable.dart';
import 'package:bunkmeter/screen/mycourse.dart';
import 'package:bunkmeter/screen/notify.dart';
import 'package:bunkmeter/screen/savetocloud.dart';
import 'package:bunkmeter/screen/statistics.dart';
import 'package:bunkmeter/widget/alert/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(26, 10, 2, 10),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('./assets/images/profile.png'),
                      width: 80,
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Text(
                        'Bunk-Meter',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    )
                  ],
                ),
                Consumer<Auth>(
                  builder: (ctx, auth, _) {
                    return Text(
                      auth.emailId == null ? 'Guest User' : auth.emailId,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    );
                  },
                ),
              ],
            )),
        SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Icon(
            MdiIcons.circleEditOutline,
            size: 26,
            color: Colors.blue,
          ),
          title: Text(
            'My Courses',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(Courses.routeName);
          },
        ),
        ListTile(
          leading: Icon(
            MdiIcons.databaseCheck,
            size: 26,
            color: Colors.orange,
          ),
          title: Text('Statistics',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.of(context).pushNamed(StatisticsScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(
            MdiIcons.contentSaveAll,
            size: 26,
            color: Colors.purple,
          ),
          title: Text('Save to Cloud',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.of(context).pushNamed(SaveTimeTable.routeName);
          },
        ),
        ListTile(
          leading: Icon(
            MdiIcons.download,
            size: 26,
            color: Colors.green,
          ),
          title: Text('Download Timetable',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.of(context).pushNamed(Download.routeName);
          },
        ),
        ListTile(
          leading: Icon(
            MdiIcons.bell,
            size: 26,
            color: Colors.red,
          ),
          title: Text('Notifications',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.of(context).pushNamed(Notify.routeName);
          },
        ),
        Consumer<Auth>(
            builder: (ctx, auth, _) => auth.isAuth
                ? ListTile(
                    leading: Icon(
                      MdiIcons.logout,
                      size: 26,
                      color: Colors.blue,
                    ),
                    title: Text('LogOut',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (ctx) => CustomConfirmDialog(
                                title: 'Log Out',
                                message: 'Are you Sure You Want to Logout?',
                              )).then((result) {
                        if (result == ConfirmAction.YES) {
                          auth.logOut();
                        }
                      });
                    },
                  )
                : ListTile(
                    leading: Icon(
                      MdiIcons.login,
                      size: 26,
                      color: Colors.blue,
                    ),
                    title: Text('Login',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).pushNamed(AuthScreen.routeName,
                          arguments: {'from': 1});
                    },
                  )),
      ],
    ));
  }
}
