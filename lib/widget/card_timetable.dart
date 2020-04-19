import 'package:bunkmeter/screen/days.dart';
import 'package:flutter/material.dart';
import 'package:koukicons/add2.dart';
import 'package:koukicons/substract2.dart';

class TimeTableCard extends StatefulWidget {
  String id;
  String time;
  String subject;
  String mode;
  int percentage;

  TimeTableCard({
    this.id,
    this.time,
    this.percentage,
    this.mode,
    this.subject,
  });

  @override
  _TimeTableCardState createState() => _TimeTableCardState();
}

class _TimeTableCardState extends State<TimeTableCard> {
  Widget addBunk() {
    var modeInt = -1;

    if (widget.mode == 'Tutorial') modeInt = 1;

    if (widget.mode == 'Practical') modeInt = 2;

    if (widget.mode == 'Lecture') modeInt = 0;

    if (modeInt == -1) return Container();
    int ind = Days.subject.indexWhere((s) => s.id == widget.id);

    return FittedBox(
      fit: BoxFit.cover,
      child: Container(
        padding: EdgeInsets.all(1),
        width: 110,
        child: Row(children: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  Days.subject[ind].bunks[modeInt]++;
                });
              }),
          Text(Days.subject[ind].bunks[modeInt].toString()),
          IconButton(
              icon: Icon(Icons.remove),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  Days.subject[ind].bunks[modeInt]--;
                });
              }),
        ]),
      ),
    );
  }

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
                    widget.time,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              title: widget.id == 'ull'
                  ? Text('')
                  : Text(
                      widget.subject,
                      style:
                          TextStyle(color: Colors.blue, fontFamily: 'OpenSans'),
                    ),
              subtitle: widget.id == 'ull'
                  ? Text('')
                  : Text(
                      '${widget.mode} | ${widget.id}',
                      style: TextStyle(fontFamily: 'Quicksand'),
                    ),
              trailing: widget.id == 'ull'
                  ? Text('')
                  : Days.BunkEditMode
                      ? addBunk()
                      : Container(
                          height: 40,
                          child: FloatingActionButton(
                            onPressed: null,
                            heroTag: widget.time,
                            backgroundColor: (widget.percentage < 50)
                                ? Colors.red
                                : (widget.percentage < 75)
                                    ? Colors.red[300]
                                    : (widget.percentage < 80)
                                        ? Colors.blue
                                        : Colors.green,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text('${widget.percentage}%')),
                          ),
                        ),
            )));
  }
}
