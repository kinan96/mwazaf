import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mwazaf_app/customWidget/serverGate.dart';
import 'package:mwazaf_app/screens/login/userController.dart';
import 'package:mwazaf_app/style/colors.dart';
import 'package:mwazaf_app/style/sizes.dart';
import 'package:mwazaf_app/screens/home/homeModel.dart';
import 'package:toast/toast.dart';

Widget listItem(BuildContext context, Item item) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Card(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height(context) * 0.02,
                    horizontal: width(context) * 0.025),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      // child: Image.network(item.image),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name ?? '',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                item.role ?? "",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: width(context) * 0.05,
                              ),
                              Text(
                                'رقم الموظف:${item.id}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.note_add,
                          color: AppColors.blue,
                        ),
                        onPressed: () {
                          TextEditingController _reason =
                              TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("إضافة عذر"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _reason,
                                      minLines: 4,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          fillColor:
                                              Colors.grey.withOpacity(0.2),
                                          hintText: "اكتب عذر للغياب"),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("إلغاء")),
                                        TextButton(
                                            onPressed: () async {
                                              ServerGate serverGate =
                                                  ServerGate();
                                              print(_reason.text);
                                              if (_reason != null &&
                                                  _reason.text.isNotEmpty)
                                                await serverGate.postData(
                                                  url: "add-absence",
                                                  // onSuccess: (body) {
                                                  //   Toast.show(body['data'],
                                                  //       Get.context);
                                                  //   Get.back();
                                                  // },
                                                  body: {
                                                    "info": _reason.text,
                                                    "user_id": item.id
                                                  },
                                                  headers: {
                                                    "Authorization":
                                                        "Bearer${userController.user.token}"
                                                  },
                                                );
                                              Get.back();
                                            },
                                            child: Text("حفظ"))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width(context) * 0.025, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: AppColors.blue,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'حضور',
                      style: TextStyle(color: AppColors.blue, fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      item.attendance != null
                          ? item.attendance.attendance
                          : "لا يوجد",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: width(context) * 0.06),
                    Icon(
                      Icons.timer,
                      color: AppColors.blue,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'تاخير',
                      style: TextStyle(color: AppColors.blue, fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      item.attendance != null
                          ? item.attendance.laate
                          : "لا يوجد",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
