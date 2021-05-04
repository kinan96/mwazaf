import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwazaf_app/style/sizes.dart';

Widget midWidget(BuildContext context) {
  return Container(
    width: width(context),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[800],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              "سجل حضور",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[800],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              "تاخير",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[800],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              "غياب",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 17,
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
