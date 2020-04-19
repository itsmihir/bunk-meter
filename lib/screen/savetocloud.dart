import 'package:bunkmeter/provider/auth.dart';
import 'package:bunkmeter/screen/authscreen.dart';
import 'package:bunkmeter/screen/days.dart';
import 'package:bunkmeter/screen/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveTimeTable extends StatelessWidget {
  static String routeName = '/save';

  Widget Logined() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Text("You Can Also Share Your Time Table With \n Your Friends"),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: FlatButton(
            color: Colors.blue,
            child: Text('Save Time Table'),
            onPressed: () {},
          ),
        ),
        Text("Share Time Table With Your Friends With the help of ID"),
        Text(
            "Just Send Time table ID To Your Friend and Ask Him to Apply That ID in Download Time Table Section"),
        Text("Don't Worry Your Bunk Count Will NOT be Shared"),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: FlatButton(
            color: Colors.blue,
            child: Text('Generate ID'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save To Cloud'),
      ),
      body: Consumer<Auth>(
        builder: (ctx, auth, _) => auth.isAuth
            ? Logined()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResult) =>
                    authResult.connectionState == ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : AuthScreen(from: 0),
              ),
      ),
      drawer: MyDrawer(),
    );
  }
}
