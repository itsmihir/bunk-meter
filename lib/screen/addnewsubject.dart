import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/widget/alert/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../provider/subject.dart';

class AddSubject extends StatefulWidget {
  static String routeName = '/add-subject';

  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  // Future<List<Subject>> subject;

  TextEditingController controller = TextEditingController();

  Subject subject = Subject(
    id: null,
    subject: null,
    total: [0, 0, 0],
    bunks: [0, 0, 0],
  );

  final formKey = new GlobalKey<FormState>();

  var dbHelper = DBHelper();

  bool isUpdating = false;

  validate(context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      Subject s = subject;
      try {
        if (Argid != null) {
          await dbHelper.update(s);
        } else
          await dbHelper.save(s);
      } catch (e) {
        print(e);
        if (e != null)
          await showDialog(
              context: context,
              builder: (ctx) => CustomAlertDialog(
                    title: 'Saving Failed!!',
                    message: 'Course With Same Code Exists',
                  ));
        return;
      }
      Navigator.of(context).pop();
    }
  }

  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  String Argid;
  void didChangeDependencies() async {
    if (_isInit) {
      Argid = ModalRoute.of(context).settings.arguments as String;
      if (Argid != null) {
        subject = await dbHelper.getSubjectByID(Argid);
      }
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Argid == null ? Text('Add Subject') : Text('Edit Subject'),
        ),
        body: _isInit == true
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          if (Argid == null)
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Subject Code',
                              ),
                              maxLines: 1,
                              // focusNode: _descriptionFocusNode,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a Subject Code';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                subject.id = value;
                              },
                            ),
                          TextFormField(
                            initialValue: subject.subject,
                            decoration: InputDecoration(
                              labelText: 'Subject Name',
                            ),
                            maxLines: 1,
                            // focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a Subject Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              subject.subject = value;
                            },
                          ),
                          TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],

                            decoration: InputDecoration(
                              labelText: 'Total Lectures Till Now',
                            ),
                            initialValue: subject.total[0].toString(),
                            maxLines: 1,
                            // focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a this field';
                              }
                            },
                            onSaved: (value) {
                              subject.total[0] = int.parse(value);
                            },
                          ),
                          TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],

                            decoration: InputDecoration(
                              labelText: 'Total Lectures Bunks Till Now',
                            ),
                            initialValue: subject.bunks[0].toString(),
                            maxLines: 1,
                            // focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a this field';
                              }
                            },
                            onSaved: (value) {
                              subject.bunks[0] = int.parse(value);
                            },
                          ),
                          TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              labelText: 'Total Tutorial Till Now',
                            ),
                            initialValue: subject.total[1].toString(),
                            maxLines: 1,
                            // focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a this field';
                              }
                            },
                            onSaved: (value) {
                              subject.total[1] = int.parse(value);
                            },
                          ),
                          TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],

                            decoration: InputDecoration(
                              labelText: 'Total Tutorial Bunks Till Now',
                            ),
                            initialValue: subject.bunks[1].toString(),
                            maxLines: 1,
                            // focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a this field';
                              }
                            },
                            onSaved: (value) {
                              subject.bunks[1] = int.parse(value);
                            },
                          ),
                          TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              labelText: 'Total Practical Till Now',
                            ),
                            initialValue: subject.total[2].toString(),
                            maxLines: 1,
                            // focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a this field';
                              }
                            },
                            onSaved: (value) {
                              subject.total[2] = int.parse(value);
                            },
                          ),
                          TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],

                            decoration: InputDecoration(
                              labelText: 'Total Practical Bunks Till Now',
                            ),
                            initialValue: subject.bunks[2].toString(),
                            maxLines: 1,
                            // focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a this field';
                              }
                            },
                            onSaved: (value) {
                              subject.bunks[2] = int.parse(value);
                            },
                          ),
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                validate(context);
                              },
                              child: Text('Save')),
                        ],
                      ),
                    )),
              ));
  }
}
