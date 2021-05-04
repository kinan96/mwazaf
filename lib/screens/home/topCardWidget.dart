import 'package:flutter/material.dart';
import 'package:mwazaf_app/style/colors.dart';
import 'package:mwazaf_app/style/sizes.dart';

Widget topCard(BuildContext context) {
  return Container(
    width: width(context),
    child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
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
                  Text('السبت 20 ابريل 2021'),
                ],
              ),
            ),
            SizedBox(width: width(context) * 0.09),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Text(
                      '24',
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
            SizedBox(
              width: width(context) * 0.02,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    '24',
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 18,
                    ),
                  ),
                  Text('موظف'),
                ],
              ),
            ),
            SizedBox(
              width: width(context) * 0.02,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    '24',
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 18,
                    ),
                  ),
                  Text('موظف'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
