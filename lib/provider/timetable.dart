import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class TimeTable {
  String day;
  List<String> lec;

  TimeTable({this.day, this.lec});

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'a': lec[0],
      'b': lec[1],
      'c': lec[2],
      'd': lec[3],
      'e': lec[4],
      'f': lec[5],
      'g': lec[6],
      'h': lec[7],
    };
  }

  static TimeTable fromMap(Map<String, dynamic> map) {
    return TimeTable(day: map['day'].toString(), lec: [
      map['a'].toString(),
      map['b'].toString(),
      map['c'].toString(),
      map['d'].toString(),
      map['e'].toString(),
      map['f'].toString(),
      map['g'].toString(),
      map['h'].toString(),
    ]);
  }
}
