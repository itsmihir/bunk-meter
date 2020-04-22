import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomToolTip extends StatelessWidget {
  String text;
  CustomToolTip({this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'KEY:',
              style: TextStyle(fontFamily: 'OpenSans', color: Colors.red),
            ),
            SizedBox(
              width: 9,
            ),
            new GestureDetector(
              child: new Tooltip(
                  preferBelow: false,
                  message: "Copy",
                  child: new Text(
                    text,
                    style: TextStyle(fontFamily: 'OpenSans', color: Colors.red),
                  )),
              onTap: () {
                Clipboard.setData(new ClipboardData(text: text));
              },
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.content_copy),
          color: Colors.black,
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: text));
          },
        )
      ],
    );
  }
}
