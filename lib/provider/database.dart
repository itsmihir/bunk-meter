import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyTimeTable {
  List<String> id;
}

class SubjectDetails {
  final String id;
  final String subject;
  final String mode;
  List<int> bunks;
  List<int> total;

  SubjectDetails({this.id, this.bunks, this.mode, this.subject, this.total});
}
