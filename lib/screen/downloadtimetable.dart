import 'package:bunkmeter/models/enum.dart';
import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/widget/alert/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Download extends StatefulWidget {
  static const routeName = '/download';

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  TextEditingController controller = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  var db = DBHelper();
  void _getTimeTable() async {
    if (formKey.currentState.validate()) {
      await showDialog(
          context: context,
          builder: (ctx) => CustomConfirmDialog(
                title: 'Download TimeTable',
                message:
                    'Alert:Downloading TimeTable will Delete Your Current Saved TimeTable and Subjects!!',
              )).then((res) async {
        if (res == ConfirmAction.YES) {
          setState(() {
            _isLoading = true;
          });
          print(controller.text + '.json');
          try {
            await db.downloadTimeTable(controller.text + '.json');
            setState(() {
              _isLoading = false;
            });
            scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: new Text("Time Table Updated"),
              duration: Duration(seconds: 2),
            ));
          } catch (e) {
            setState(() {
              _isLoading = false;
            });
            scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: e.toString().contains("file does not exist")
                  ? Text(e.toString())
                  : Text("Something went wrong!!"),
              duration: Duration(seconds: 2),
            ));
            print(e);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Download Time Table'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 17, 25, 17),
                  child: Text(
                    "Ask Your Friend To Generate a Key From \"SAVE TO CLOUD\" Section And Apply That Key Here Easy!!",
                    style: TextStyle(fontFamily: 'Lato', fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: 'Enter Key Here',
                        errorMaxLines: 1,
                        helperMaxLines: 1,
                        hintMaxLines: 1,
                      ),
                      validator: (value) {
                        if (value.isEmpty) return 'Key Can Not Be Empty';
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                      },
                    ),
                  ),
                ),
                FlatButton(
                  child: Text('Download'),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    _getTimeTable();
                  },
                )
              ],
            ),
    );
  }
}
