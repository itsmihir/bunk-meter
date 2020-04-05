import 'package:bunkmeter/provider/subject.dart';
import 'package:flutter/material.dart';

class BottomEdit extends StatefulWidget {
  List<Subject> subject;
  BottomEdit(this.subject);
  @override
  _BottomEditState createState() => _BottomEditState();
}

class _BottomEditState extends State<BottomEdit> {
  int curSub = -1;
  int curMode = -1;

  List<String> mode = ['Lecture', 'Tutorial', 'Pratical', 'Erase'];
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 0.3,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 0; i < widget.subject.length; i++)
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffb1C95FA),
                              border: i == curSub
                                  ? Border.all(color: Colors.black, width: 3)
                                  : null,
                              borderRadius: i == curSub
                                  ? BorderRadius.circular(6)
                                  : null),
                          padding: const EdgeInsets.all(10),
                          height: media.height * 0.153,
                          width: media.width * 0.27,
                          child: GestureDetector(
                            child: Text(
                              widget.subject[i].subject,
                              style: TextStyle(fontFamily: 'Lato'),
                            ),
                            onTap: () {
                              setState(() {
                                curSub = i;
                              });
                              print(curSub);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < 4; i++)
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffb32A0FC),
                              border: i == curMode
                                  ? Border.all(color: Colors.black, width: 3)
                                  : null,
                              borderRadius: i == curMode
                                  ? BorderRadius.circular(6)
                                  : null),
                          padding: const EdgeInsets.all(8),
                          height: media.height * 0.1,
                          width: media.width * 0.22,
                          child: GestureDetector(
                            child: Text(
                              mode[i],
                              style: TextStyle(fontFamily: 'Lato'),
                            ),
                            onTap: () {
                              setState(() {
                                curMode = i;
                              });
                              print(curMode);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
