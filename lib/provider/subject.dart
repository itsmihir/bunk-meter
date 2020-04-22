class Subject {
  String id;
  String subject;
  List<int> bunks;
  List<int> total;

  Subject({this.id, this.bunks, this.subject, this.total});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'bunksLec': bunks[0],
      'bunksTut': bunks[1],
      'bunksPra': bunks[2],
      'totalLec': total[0],
      'totalTut': total[1],
      'totalPra': total[2],
    };
  }

  static Subject fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'].toString(),
      subject: map['subject'].toString(),
      bunks: [map['bunksLec'], map['bunksTut'], map['bunksPra']],
      total: [
        map['totalLec'],
        map['totalTut'],
        map['totalPra'],
      ],
    );
  }

  static Map<String, dynamic> clearCount(Map<String, dynamic> map) {
    map['bunksLec'] = 0;
    map['bunksTut'] = 0;
    map['bunksPra'] = 0;
    map['totalLec'] = 0;
    map['totalTut'] = 0;
    map['totalPra'] = 0;
    return map;
  }
}
