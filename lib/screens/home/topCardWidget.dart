import 'package:flutter/material.dart';
import 'package:mwazaf_app/style/colors.dart';
import 'package:mwazaf_app/style/sizes.dart';

Widget topCard(BuildContext context, int count) {
  return Container(
    width: width(context),
    child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.wb_sunny,
              size: 30,
              color: AppColors.blue,
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'صباح الخير',
                    style: TextStyle(
                      color: AppColors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(DateTime.now().toIso8601String().split("T")[0]),
                ],
              ),
            ),
            Spacer(),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    count == null
                        ? CircularProgressIndicator()
                        : Text(
                            '$count',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 18,
                            ),
                          ),
                    Text('موظف'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
