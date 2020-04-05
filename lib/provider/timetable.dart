class TimeTable {
  String day;
  List<String> lec;

  TimeTable({this.day, this.lec});

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      '1': lec[0],
      '2': lec[1],
      '3': lec[2],
      '4': lec[3],
      '5': lec[4],
      '6': lec[5],
      '7': lec[6],
      '8': lec[7],
    };
  }

  static TimeTable fromMap(Map<String, dynamic> map) {
    return TimeTable(day: map['day'].toString(), lec: [
      map['1'].toString(),
      map['2'].toString(),
      map['3'].toString(),
      map['4'].toString(),
      map['5'].toString(),
      map['6'].toString(),
      map['7'].toString(),
      map['8'].toString(),
    ]);
  }
}
