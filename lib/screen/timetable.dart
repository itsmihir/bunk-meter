import 'package:bunkmeter/provider/subject.dart';
import 'package:bunkmeter/provider/timetable.dart';
import 'package:bunkmeter/screen/days.dart';
import 'package:bunkmeter/widget/bottomedit.dart';
import 'package:bunkmeter/widget/card_timetable.dart';
import 'package:flutter/material.dart';

class TimeTableScreen extends StatefulWidget {
  List<Subject> subject;
  TimeTable timetable;
  String id;
  TimeTableScreen({this.subject, this.timetable, this.id});

  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  int calculatePercentage(var sub, var mode) {
    int per = 0;

    mode = int.parse(mode);
    if (sub.total[mode] != 0)
      per = (100 * ((sub.total[mode] - sub.bunks[mode]) / sub.total[mode]))
          .toInt();
    return per;
  }

  var time = [
    '8:30 AM',
    '9:30 AM',
    '10:30 AM',
    '11:30 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM'
  ];

  String getMode(String i) {
    if (i.startsWith('0')) return 'Lecture';

    if (i.startsWith('1')) return 'Tutorial';

    if (i.startsWith('2')) return 'Practical';
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Days.timetable == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Days.editMode
                ? Column(
                    children: <Widget>[
                      for (int i = 0; i < 8; i++)
                        GestureDetector(
                          onTap: () {
                            int ind = Days.timetable
                                .indexWhere((test) => test.day == widget.id);

                            setState(() {
                              if (BottomEdit.curMode == 3) {
                                Days.timetable[ind].lec[i] = 'null';
                              } else {
                                Days.timetable[ind].lec[i] =
                                    BottomEdit.curSub != -1 &&
                                            BottomEdit.curMode != -1
                                        ? BottomEdit.curMode.toString() +
                                            widget.subject[BottomEdit.curSub].id
                                        : widget.timetable.lec[i];
                              }
                              widget.timetable.lec[i] =
                                  Days.timetable[ind].lec[i];
                            });
                          },
                          child: TimeTableCard(
                              id: widget.timetable.lec[i].substring(1),
                              time: time[i],
                              percentage: widget.timetable.lec[i] == 'null'
                                  ? 0
                                  : calculatePercentage(
                                      widget.subject.firstWhere((test) =>
                                          test.id ==
                                          widget.timetable.lec[i].substring(1)),
                                      widget.timetable.lec[i][0]),
                              mode: widget.timetable.lec[i] == 'null'
                                  ? ''
                                  : getMode(widget.timetable.lec[i]),
                              subject: widget.timetable.lec[i] == 'null'
                                  ? ''
                                  : widget.subject
                                      .firstWhere((test) =>
                                          test.id ==
                                          widget.timetable.lec[i].substring(1))
                                      .subject),
                        ),
                      SizedBox(
                        height: media.height * 0.3,
                      )
                    ],
                  )
                : Column(
                    children: <Widget>[
                      TimeTableCard(
                        id: widget.timetable.lec[0].substring(1),
                        time: '8:30 AM',
                        percentage: widget.timetable.lec[0] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[0].substring(1)),
                                widget.timetable.lec[0][0]),
                        mode: widget.timetable.lec[0] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[0]),
                        subject: widget.timetable.lec[0] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[0].substring(1))
                                .subject
                                .toString(),
                      ),
                      TimeTableCard(
                        id: widget.timetable.lec[1].substring(1),
                        time: '9:30 AM',
                        percentage: widget.timetable.lec[1] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[1].substring(1)),
                                widget.timetable.lec[1][0]),
                        mode: widget.timetable.lec[1] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[1]),
                        subject: widget.timetable.lec[1] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[1].substring(1))
                                .subject
                                .toString(),
                      ),
                      TimeTableCard(
                        id: widget.timetable.lec[2].substring(1),
                        time: '10:30 AM',
                        percentage: widget.timetable.lec[2] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[2].substring(1)),
                                widget.timetable.lec[2][0]),
                        mode: widget.timetable.lec[2] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[2]),
                        subject: widget.timetable.lec[2] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[2].substring(1))
                                .subject
                                .toString(),
                      ),
                      TimeTableCard(
                        id: widget.timetable.lec[3].substring(1),
                        time: '11:30 AM',
                        percentage: widget.timetable.lec[3] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[3].substring(1)),
                                widget.timetable.lec[3][0]),
                        mode: widget.timetable.lec[3] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[3]),
                        subject: widget.timetable.lec[3] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[3].substring(1))
                                .subject
                                .toString(),
                      ),
                      TimeTableCard(
                        id: widget.timetable.lec[4].substring(1),
                        time: '2:00 PM',
                        percentage: widget.timetable.lec[4] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[4].substring(1)),
                                widget.timetable.lec[4][0]),
                        mode: widget.timetable.lec[4] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[4]),
                        subject: widget.timetable.lec[4] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[4].substring(1))
                                .subject
                                .toString(),
                      ),
                      TimeTableCard(
                        id: widget.timetable.lec[5].substring(1),
                        time: '3:00 PM',
                        percentage: widget.timetable.lec[5] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[5].substring(1)),
                                widget.timetable.lec[5][0]),
                        mode: widget.timetable.lec[5] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[5]),
                        subject: widget.timetable.lec[5] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[5].substring(1))
                                .subject
                                .toString(),
                      ),
                      TimeTableCard(
                        id: widget.timetable.lec[6].substring(1),
                        time: '4:00 PM',
                        percentage: widget.timetable.lec[6] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[6].substring(1)),
                                widget.timetable.lec[6][0]),
                        mode: widget.timetable.lec[6] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[6]),
                        subject: widget.timetable.lec[6] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[6].substring(1))
                                .subject
                                .toString(),
                      ),
                      TimeTableCard(
                        id: widget.timetable.lec[7].substring(1),
                        time: '5:00 PM',
                        percentage: widget.timetable.lec[7] == 'null'
                            ? 0
                            : calculatePercentage(
                                widget.subject.firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[7].substring(1)),
                                widget.timetable.lec[7][0]),
                        mode: widget.timetable.lec[7] == 'null'
                            ? ''
                            : getMode(widget.timetable.lec[7]),
                        subject: widget.timetable.lec[7] == 'null'
                            ? ''
                            : widget.subject
                                .firstWhere((test) =>
                                    test.id ==
                                    widget.timetable.lec[7].substring(1))
                                .subject
                                .toString(),
                      ),
                    ],
                  ),
          );
  }
}
