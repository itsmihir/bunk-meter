import 'package:flutter/material.dart';

class TimeTableCard extends StatelessWidget {
  String id;
  String time;
  String subject;
  String mode;
  int percentage;

  TimeTableCard({this.id, this.time, this.percentage, this.mode, this.subject});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(3),
        height: 100,
        child: Card(
            margin: const EdgeInsets.all(0),
            child: ListTile(
              leading: Container(
                width: 70,
                child: FlatButton(
                  onPressed: null,
                  disabledColor: Colors.blue[100],
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(2),
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              title: id == 'null'
                  ? Text('')
                  : Text(
                      subject,
                      style:
                          TextStyle(color: Colors.blue, fontFamily: 'OpenSans'),
                    ),
              subtitle: id == 'null'
                  ? Text('')
                  : Text(
                      '$mode | $id',
                      style: TextStyle(fontFamily: 'Quicksand'),
                    ),
              trailing: id == 'null'
                  ? Text('')
                  : Container(
                      height: 40,
                      child: FloatingActionButton(
                        onPressed: null,
                        heroTag: time,
                        backgroundColor: (percentage < 50)
                            ? Colors.red
                            : (percentage < 75)
                                ? Colors.red[300]
                                : (percentage < 80)
                                    ? Colors.blue
                                    : Colors.green,
                        child: FittedBox(
                            fit: BoxFit.fill, child: Text('$percentage%')),
                      ),
                    ),
            )));
  }
}
