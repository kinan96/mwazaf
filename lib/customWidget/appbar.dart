import 'package:flutter/material.dart';
import 'package:mwazaf_app/screens/login/userController.dart';
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
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage("assets/images/user.png"),
          foregroundImage: userController.user.avatar == null &&
                  userController.user.image == null
              ? null
              : NetworkImage(
                  userController.user.avatar ?? userController.user.image),
          radius: 15,
        ),
      ],
    ),
    elevation: 0,
  );
}
