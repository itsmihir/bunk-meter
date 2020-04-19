import 'dart:math';

import 'package:bunkmeter/provider/database.dart';
import 'package:bunkmeter/provider/subject.dart';
import 'package:flutter/material.dart';

class StatisticsWidget extends StatefulWidget {
  final Subject subject;
  StatisticsWidget(this.subject);
  @override
  _StatisticsWidgetState createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  DBHelper dbHelper = DBHelper();

  List<Subject> subject;

  bool _expanded = false;
  Widget percentage(int x, int total) {
    if (total == 0 || x == 0) return Text('0%');

    var per = (total - x) / total * 100;
    per = min(per, 100);

    return Text(per.toInt().toString() + '%');
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.subject.subject),
            subtitle: Text(widget.subject.id),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  print(widget.subject);
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(""),
                        SizedBox(
                          width: media.width * 0.20,
                        ),
                        Text('Bunks/Total'),
                        SizedBox(
                          width: media.width * 0.05,
                        ),
                        Text("Percentage")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Lecture"),
                        SizedBox(
                          width: media.width * 0.10,
                        ),
                        Text(widget.subject.bunks[0].toString() +
                            '/' +
                            widget.subject.total[0].toString()),
                        SizedBox(
                          width: media.width * 0.1,
                        ),
                        percentage(
                            widget.subject.bunks[0], widget.subject.total[0]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Practical"),
                        SizedBox(
                          width: media.width * 0.1,
                        ),
                        Text(widget.subject.bunks[2].toString() +
                            '/' +
                            widget.subject.total[2].toString()),
                        SizedBox(
                          width: media.width * 0.1,
                        ),
                        percentage(
                            widget.subject.bunks[2], widget.subject.total[2]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Tutorial"),
                        SizedBox(
                          width: media.width * 0.1,
                        ),
                        Text(widget.subject.bunks[1].toString() +
                            '/' +
                            widget.subject.total[1].toString()),
                        SizedBox(
                          width: media.width * 0.1,
                        ),
                        percentage(
                            widget.subject.bunks[1], widget.subject.total[1]),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
