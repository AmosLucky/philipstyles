import 'package:flutter/material.dart';

import '../constants.dart';

Widget SingleData({size, icon, text}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: 10,
    ),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: size.width / 7),
          child: Icon(
            icon,
            color: primaryColor,
          ),
        ),
        Container(
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    ),
  );
}
