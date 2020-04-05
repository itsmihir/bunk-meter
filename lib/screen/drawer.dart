import 'package:bunkmeter/provider/auth.dart';
import 'package:bunkmeter/screen/mycourse.dart';
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
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text('Keep Calm And Bunk Lecture',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
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
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            MdiIcons.bell,
            size: 26,
            color: Colors.red,
          ),
          title: Text('Notifications',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {},
        ),
        // ListTile(
        //   leading: Icon(
        //     MdiIcons.logout,
        //     size: 26,
        //   ),
        // title: Text('Logout',
        //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        // onTap: () {
        //   Provider.of<Auth>(context, listen: false).logOut();
        // },
        //  ),
      ],
    ));
  }
}
