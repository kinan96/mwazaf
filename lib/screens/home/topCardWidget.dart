import 'package:flutter/material.dart';
import 'package:mwazaf_app/style/colors.dart';
import 'package:mwazaf_app/style/sizes.dart';

Widget topCard(BuildContext context, int count, int attendance, int absence) {
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
              DateTime.now().hour >= 12
                  ? Icons.nights_stay_sharp
                  : Icons.wb_sunny,
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
                    DateTime.now().hour >= 12 ? 'مساء الخير' : 'صباح الخير',
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
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    count == null
                        ? CircularProgressIndicator()
                        : Text(
                            '$attendance',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 18,
                            ),
                          ),
                    Text('حضور'),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    count == null
                        ? CircularProgressIndicator()
                        : Text(
                            '$absence',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 18,
                            ),
                          ),
                    Text('غياب'),
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
