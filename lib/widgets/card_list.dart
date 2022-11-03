import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../utils/utils.dart';

Widget SingleData({size, icon, text, context}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: 10,
    ),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: size.width / 12),
          child: Icon(
            icon,
            color: primaryColor,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onHorizontalDragStart: (v) async {
              await Clipboard.setData(text);
              showSnackBar(context, "Copied! " + text);
            },
            onTap: () async {
              
              await Clipboard.setData(ClipboardData(text:text));
              showSnackBar(context, "Copied! " + text);
            },
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    ),
  );
}
