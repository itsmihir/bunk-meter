import 'package:bunkmeter/widget/card_timetable.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatelessWidget {
  final day;
  TimeTable(this.day);
  var dume = [
    {
      {'subject': 'DSA', 'mode': 'practical'}
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TimeTableCard(
            id: 'CO200',
            time: '8:30 AM',
            percentage: 100,
            mode: 'Lecture',
            subject: 'Data Structure and Algorithm',
          ),
          TimeTableCard(
            id: 'CO200',
            time: '9:30 AM',
            percentage: 100,
            mode: 'Lecture',
            subject: 'Data Structure and Algorithm',
          ),
          TimeTableCard(
            id: 'CO200',
            time: '10:30 AM',
            percentage: 100,
            mode: 'Lecture',
            subject: 'Data Structure and Algorithm',
          ),
          TimeTableCard(
            id: 'CO200',
            time: '11:30 AM',
            percentage: 100,
            mode: 'Lecture',
            subject: 'Data Structure and Algorithm',
          ),
          TimeTableCard(
            id: 'CO200',
            time: '2:00 PM',
            percentage: 100,
            mode: 'Lecture',
            subject: 'Data Structure and Algorithm',
          ),
          TimeTableCard(
            id: 'CO200',
            time: '3:00 PM',
            percentage: 100,
            mode: 'Lecture',
            subject: 'Data Structure and Algorithm',
          ),
        ],
      ),
    );
    ;
  }
}
