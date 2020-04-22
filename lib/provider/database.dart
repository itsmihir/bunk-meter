import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:bunkmeter/models/http_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:workmanager/workmanager.dart';
import './timetable.dart';
import 'package:http/http.dart' as http;
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
    try {
      io.Directory documentsDirectory =
          await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, DB_NAME);
      var db = await openDatabase(path, version: 1, onCreate: _onCreate);

      return db;
    } catch (e) {
      print(e);
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID STRING PRIMARY KEY, $SUBJECT TEXT, $bunkLec INTEGER, $bunkTut INTEGER, $bunkPra INTEGER,  $totalLec INTEGER, $totalTut INTEGER, $totalPra INTEGER)");
    await _onCreatett(db, version);
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
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Subject> subjects = [];

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        subjects.add(Subject.fromMap(maps[i]));
      }
    }

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

  Future<void> deleteAll() async {
    var dbClient = await db;

    await dbClient.rawQuery("DELETE FROM $TABLE");
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

  Future<void> saveToJSONFile(String fileName) async {
    print('Writing from Blockchain...');
    var dbClient = await db;
    final url = 'https://kfs4.moibit.io/moibit/v0/writefile';
    try {
      List<Map> timetableFile =
          await dbClient.rawQuery("SELECT * FROM $TABLETT");
      List<Map> subjectFile = await dbClient.rawQuery("SELECT * FROM $TABLE");
      // print(subjectFile);
      // if (subjectFile.length > 0) {
      //   for (int i = 0; i < subjectFile.length; i++) {
      //     print(subjectFile[i]);
      //     subjectFile[i] = Subject.clearCount(subjectFile[i]);
      //   }
      // }
      io.Directory dir = await getTemporaryDirectory();
      io.File filett = new io.File(dir.path + '/' + 'tt' + fileName);
      io.File filesub = new io.File(dir.path + '/' + 'sub' + fileName);
      filett.createSync();
      filett.writeAsStringSync(json.encode(timetableFile));
      filesub.writeAsStringSync(json.encode(subjectFile));
      Dio dio = new Dio();
      // FormData formdata = new FormData(); // just like JS
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(filett.path, filename: 'tt' + fileName)
      });
      var response = await dio.post(
        url,
        data: formData,
        options: Options(
            headers: {
              "api_key": "",
              "api_secret":
                  "",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response);

      // Add Subject file
      formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filesub.path,
            filename: 'sub' + fileName)
      });
      response = await dio.post(
        url,
        data: formData,
        options: Options(
            headers: {
              "api_key": "",
              "api_secret
                  "",
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

  Future<void> deleteFromServer(String fileName) async {
    final url = 'https://kfs4.moibit.io/moibit/v0/remove';
    print('Deleteing from Blockchain...');
    try {
      final res = await http.post(url,
          headers: {
            "api_key": "",
            "api_secret":
                "",
          },
          body: json.encode({"path": 'tt' + fileName}));
      print(res.body);
      //Delete Subject File
      final res1 = await http.post(url,
          headers: {
            "api_key": "",
            "api_secret":
                "",
          },
          body: json.encode({"path": 'sub' + fileName}));
      print(res1.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadTimeTable(String key) async {
    final url = 'https://kfs4.moibit.io/moibit/v0/readfile';
    print('Downloading from Blockchain...');
    try {
      final res = await http.post(url,
          headers: {
            "api_key": "",
            "api_secret":
                "",
          },
          body: json.encode({"fileName": 'tt' + key}));
      var map = json.decode(res.body);
      print(map);
      if (map["meta"]["message"].toString().contains("failed"))
        throw HttpException(map["data"]);
      List<TimeTable> tt = [];
      for (int i = 0; i < map.length; i++) {
        tt.add(TimeTable.fromMap(map[i]));
      }
      await this.updatett(tt);

      final res1 = await http.post(url,
          headers: {
            "api_key": "",
            "api_secret":
                "",
          },
          body: json.encode({"fileName": 'sub' + key}));
      map = json.decode(res1.body);
      if (map["meta"]["message"].toString().contains("failed"))
        throw HttpException(map["data"]);
      List<Subject> sub = [];
      print(map);
      await this.deleteAll();
      for (int i = 0; i < map.length; i++) {
        sub.add(Subject.fromMap(map[i]));
        print(sub[i]);
        await this.save(sub[i]);
      }
    } catch (e) {
      print(e);
      throw HttpException(e.toString());
    }
  }

  // Auto update Bunk Count
  void callbackDispatcher() {
    Workmanager.executeTask((task, inputData) {
      print(
          "Native called background task: "); //simpleTask will be emitted here.
      return Future.value(true);
    });
  }
}
