import 'dart:math';

import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/provider/subject.dart';
import 'package:bunkmeter/widget/stat_widget.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  static const routeName = '/sat';

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DBHelper dbHelper = DBHelper();

  List<Subject> subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Statistics'),
        ),
        body: FutureBuilder(
          future: dbHelper.getSubject(),
          builder: (ctx, sn) {
            if (sn.hasData) {
              subject = sn.data;
              return ListView.builder(
                itemCount: subject.length,
                itemBuilder: (context, i) {
                  return StatisticsWidget(subject[i]);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
