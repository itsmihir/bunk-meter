import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/provider/subject.dart';
import 'package:bunkmeter/provider/timetable.dart';
import 'package:bunkmeter/widget/card_timetable.dart';
import 'package:flutter/material.dart';

class TimeTableScreen extends StatelessWidget {
  List<Subject> subject;
  TimeTable timetable;
  TimeTableScreen({this.subject, this.timetable});

  // List<Subject> subject;
  int calculatePercentage(var sub) {
    var per = 0;
    if (sub.total[0] != 0) per = sub.bunks[0] / sub.total[0];
    return per;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TimeTableCard(
            id: timetable.lec[0],
            time: '8:30 AM',
            percentage: timetable.lec[0] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[0])),
            mode: 'Lecture',
            subject: timetable.lec[0] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[0])
                    .toString(),
          ),
          TimeTableCard(
            id: timetable.lec[1],
            time: '9:30 AM',
            percentage: timetable.lec[1] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[1])),
            mode: 'Lecture',
            subject: timetable.lec[1] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[1])
                    .toString(),
          ),
          TimeTableCard(
            id: timetable.lec[2],
            time: '10:30 AM',
            percentage: timetable.lec[2] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[2])),
            mode: 'Lecture',
            subject: timetable.lec[2] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[2])
                    .toString(),
          ),
          TimeTableCard(
            id: timetable.lec[3],
            time: '11:30 AM',
            percentage: timetable.lec[3] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[3])),
            mode: 'Lecture',
            subject: timetable.lec[3] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[3])
                    .toString(),
          ),
          TimeTableCard(
            id: timetable.lec[4],
            time: '2:00 PM',
            percentage: timetable.lec[4] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[4])),
            mode: 'Lecture',
            subject: timetable.lec[4] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[4])
                    .toString(),
          ),
          TimeTableCard(
            id: timetable.lec[5],
            time: '3:00 PM',
            percentage: timetable.lec[5] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[5])),
            mode: 'Lecture',
            subject: timetable.lec[5] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[5])
                    .toString(),
          ),
          TimeTableCard(
            id: timetable.lec[6],
            time: '4:00 PM',
            percentage: timetable.lec[6] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[6])),
            mode: 'Lecture',
            subject: timetable.lec[6] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[6])
                    .toString(),
          ),
          TimeTableCard(
            id: timetable.lec[7],
            time: '5:00 PM',
            percentage: timetable.lec[7] == 'null'
                ? 0
                : calculatePercentage(
                    subject.firstWhere((test) => test.id == timetable.lec[7])),
            mode: 'Lecture',
            subject: timetable.lec[7] == 'null'
                ? ''
                : subject
                    .firstWhere((test) => test.id == timetable.lec[7])
                    .toString(),
          ),
        ],
      ),
    );
  }
}
