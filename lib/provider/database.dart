import 'dart:async';
import 'dart:io' as io;
import './timetable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import './subject.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String SUBJECT = 'subject';
  static const String TABLE = 'Subjects';
  static const String DB_NAME = 'Subjects.db';

  static const String DAY = 'day';
  static const String TABLETT = 'TIMETABLE';
  static const String MON = 'mon';
  static const String TUE = 'tue';
  static const String WED = 'wed';
  static const String THR = 'thr';
  static const String FRI = 'fri';

  static const String bunkLec = 'bunksLec';
  static const String bunkTut = 'bunksTut';
  static const String bunkPra = 'bunksPra';

  static const String totalLec = 'totalLec';
  static const String totalTut = 'totalTut';
  static const String totalPra = 'totalPra';

  List<Subject> cache;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID STRING PRIMARY KEY, $SUBJECT TEXT, $bunkLec INTEGER, $bunkTut INTEGER, $bunkPra INTEGER,  $totalLec INTEGER, $totalTut INTEGER, $totalPra INTEGER)");
    _onCreatett(db, version);
  }

  _onCreatett(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLETT ($DAY STRING PRIMARY KEY , 'a' TEXT,'b' TEXT,'c' TEXT,'d' TEXT,'e' TEXT,'f' TEXT,'g' TEXT,'h' TEXT)");

    var genesis = [
      {
        'day': 'mon',
        'a': 'null',
        'b': 'null',
        'c': 'null',
        'd': 'null',
        'e': 'null',
        'f': 'null',
        'g': 'null',
        'h': 'null',
      },
      {
        'day': 'tue',
        'a': 'null',
        'b': 'null',
        'c': 'null',
        'd': 'null',
        'e': 'null',
        'f': 'null',
        'g': 'null',
        'h': 'null',
      },
      {
        'day': 'wed',
        'a': 'null',
        'b': 'null',
        'c': 'null',
        'd': 'null',
        'e': 'null',
        'f': 'null',
        'g': 'null',
        'h': 'null',
      },
      {
        'day': 'thr',
        'a': 'null',
        'b': 'null',
        'c': 'null',
        'd': 'null',
        'e': 'null',
        'f': 'null',
        'g': 'null',
        'h': 'null',
      },
      {
        'day': 'fri',
        'a': 'null',
        'b': 'null',
        'c': 'null',
        'd': 'null',
        'e': 'null',
        'f': 'null',
        'g': 'null',
        'h': 'null',
      },
    ];

    for (int i = 0; i < 5; i++)
      try {
        await db.insert(TABLETT, genesis[i]);
      } catch (e) {
        print(e);
        if (e == null) print("TimeTable Created");
      }
  }

  Future<Subject> save(Subject subject) async {
    var dbClient = await db;

    try {
      await dbClient.insert(TABLE, subject.toMap());
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw (e);
      }
    }
    return subject;
  }

  Future<List<Subject>> getSubject() async {
    var dbClient = await db;
    // List<Map> maps = await dbClient.query(TABLE, columns: [ID]);
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Subject> subjects = [];

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        subjects.add(Subject.fromMap(maps[i]));
      }
    }
    cache = subjects;
    return subjects;
  }

  Future<List<TimeTable>> gettimetable() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLETT");

    List<TimeTable> tt = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        tt.add(TimeTable.fromMap(maps[i]));
      }
    }
    return tt;
  }

  Future<Subject> getSubjectByID(id) async {
    var dbClient = await db;
    // List<Map> maps = await dbClient.query(TABLE, columns: [ID]);
    List<Map> maps =
        await dbClient.rawQuery("SELECT * FROM $TABLE WHERE ID==\"$id\"");
    return (Subject.fromMap(maps[0]));
  }

  Future<int> delete(String id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Subject subject) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, subject.toMap(),
        where: '$ID = ?', whereArgs: [subject.id]);
  }

  Future<int> updatett(TimeTable tt) async {
    var dbClient = await db;
    return await dbClient
        .update(TABLETT, tt.toMap(), where: '$ID = ?', whereArgs: [tt.day]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
