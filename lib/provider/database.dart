import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:dio/dio.dart';

import './timetable.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
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
    print(subjects.length);

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

  Future<void> delete(String id) async {
    var dbClient = await db;
    try {
      List<TimeTable> tt = await this.gettimetable();
      for (int i = 0; i < tt.length; i++) {
        for (int j = 0; j < tt[i].lec.length; j++) {
          if (tt[i].lec[j] == '0' + id ||
              tt[i].lec[j] == '1' + id ||
              tt[i].lec[j] == '2' + id) tt[i].lec[j] = 'null';
        }
      }
      await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
      await this.updatett(tt);
    } catch (e) {
      print(e);
    }
  }

  Future<int> update(Subject subject) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, subject.toMap(),
        where: '$ID = ?', whereArgs: [subject.id]);
  }

  Future<void> updatett(List<TimeTable> tt) async {
    var dbClient = await db;
    for (int i = 0; i < tt.length; i++) {
      try {
        await dbClient.update(TABLETT, tt[i].toMap(),
            where: '$DAY = ?', whereArgs: [tt[i].day]).then((ok) {
          print('updated');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

// decentralized data storage

  Future<void> SaveToJSONFile(String fileName) async {
    print('Writing from Blockchain...');
    var dbClient = await db;
    final url = 'https://kfs4.moibit.io/moibit/v0/writefile';
    List<Map> fileContent = await dbClient.rawQuery("SELECT * FROM $TABLETT");
    try {
      Directory dir = await getTemporaryDirectory();
      File file = new File(dir.path + '/' + fileName);
      file.createSync();
      file.writeAsStringSync(json.encode(fileContent));
      Dio dio = new Dio();
      FormData formdata = new FormData(); // just like JS
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName)
      });
      var response = await dio.post(
        url,
        data: formData,
        options: Options(
            headers: {
              "api_key": "12D3KooWJn8t1aFq8WjYiHCshBAwvDQH8wDFY5Y2Ue2ZPna89Zgb",
              "api_secret":
                  "080112407b10de977fde0a6dca066d04a40dff20ebf89b37f88ca9555d46f6e478a1f1d18526fecf3b4addea43ee4ae51248c1bdb0f9c8507e696d56ee55926f384dfa08",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future<void> DeleteFromServer(String fileName) async {
    final url = 'https://kfs4.moibit.io/moibit/v0/remove';
    print('Deleteing from Blockchain...');
    try {
      final res = await http.post(url,
          headers: {
            "api_key": "12D3KooWJn8t1aFq8WjYiHCshBAwvDQH8wDFY5Y2Ue2ZPna89Zgb",
            "api_secret":
                "080112407b10de977fde0a6dca066d04a40dff20ebf89b37f88ca9555d46f6e478a1f1d18526fecf3b4addea43ee4ae51248c1bdb0f9c8507e696d56ee55926f384dfa08",
          },
          body: json.encode({"path": fileName}));
      print(res.body);
    } catch (e) {
      print(e);
    }
  }
}
