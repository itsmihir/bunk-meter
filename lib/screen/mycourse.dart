import 'package:bunkmeter/models/enum.dart';
import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/provider/subject.dart';
import 'package:bunkmeter/screen/addnewsubject.dart';
import 'package:bunkmeter/widget/alert/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:koukicons/deleteDatabase.dart';
import 'package:koukicons/edit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Courses extends StatefulWidget {
  static String routeName = '/courses';

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  var dbHelper = DBHelper();
  bool isLoading = false;
  Future<List<Subject>> subject;

  list() {
    return Container(
      child: FutureBuilder(
        future: dbHelper.getSubject(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return Center(child: Text("No Courses Found"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Container dataTable(List<Subject> subjects) {
    var media = MediaQuery.of(context).size;
    return Container(
        child: ListView.builder(
      itemBuilder: (ctx, ind) => Container(
          padding: const EdgeInsets.all(3),
          height: 100,
          child: Card(
              margin: const EdgeInsets.all(0),
              child: ListTile(
                  title: Text(
                    subjects[ind].subject,
                    style:
                        TextStyle(color: Colors.blue, fontFamily: 'OpenSans'),
                  ),
                  subtitle: Text(
                    '${subjects[ind].id}',
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                  trailing: Container(
                    width: media.width * 0.28,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            MdiIcons.tableEdit,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                AddSubject.routeName,
                                arguments: subjects[ind].id);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            MdiIcons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (ctx) => CustomConfirmDialog(
                                      title: 'Delete Course!!',
                                      message:
                                          'Are You Sure You Want to Delete the Course ?',
                                    )).then((result) async {
                              if (result == ConfirmAction.YES) {
                                setState(() {
                                  isLoading = true;
                                });
                                await dbHelper
                                    .delete(subjects[ind].id)
                                    .then((d) {
                                  print('done');
                                  setState(() {
                                    isLoading = false;
                                  });
                                }).catchError((e) {
                                  print(e);
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )))),
      itemCount: subjects.length,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Courses',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(MdiIcons.plus),
              onPressed: () {
                Navigator.of(context).pushNamed(AddSubject.routeName);
              })
        ],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) : list(),
    );
  }
}

// DataTable(
//         columns: [
//           DataColumn(
//             label: Text('NAME'),
//           ),
//           DataColumn(
//             label: Text('DELETE'),
//           )
//         ],
//         rows: subjects
//             .map(
//               (sub) => DataRow(cells: [
//                 DataCell(
//                   Text(sub.subject.toString()),
//                   onTap: () {},
//                 ),
//                 DataCell(IconButton(
//                   icon: Icon(MdiIcons.deleteForever),
//                   onPressed: () {
//                     setState(() {
//                       dbHelper.delete(sub.id);
//                     });
//                   },
//                 )),
//               ]),
//             )
//             .toList(),
//       ),
