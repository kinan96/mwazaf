import 'package:flutter/material.dart';
import 'package:mwazaf_app/style/colors.dart';

PreferredSizeWidget myAppBar(BuildContext context, String title, String image) {
  return AppBar(
    backgroundColor: AppColors.blue,
    title: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 15,
        ),
      ],
    ),
    elevation: 0,
  );
}
