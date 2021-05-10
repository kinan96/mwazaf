import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getlib;
import 'package:mwazaf_app/customWidget/appbar.dart';
import 'package:mwazaf_app/customWidget/myBottom.dart';
import 'package:mwazaf_app/customWidget/serverGate.dart';
import 'package:mwazaf_app/customWidget/shared_preferences_helper.dart';
import 'package:mwazaf_app/screens/home/listItem.dart';
import 'package:mwazaf_app/screens/home/midWidget.dart';
import 'package:mwazaf_app/screens/home/topCardWidget.dart';
import 'package:mwazaf_app/screens/login/login.dart';
import 'package:mwazaf_app/screens/login/userController.dart';
import 'package:mwazaf_app/style/colors.dart';
import 'package:mwazaf_app/style/sizes.dart';
import 'package:mwazaf_app/customWidget/mySmartRefresher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'homeModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  initState() {
    _getHomeModel(null);
    super.initState();
  }

  Future counter() async {
    String qr = await FlutterBarcodeScanner.scanBarcode(
        '#004297', 'colse', true, ScanMode.DEFAULT);
    getlib.Get.back();
    print(qr);
    ServerGate serverGate = ServerGate();
    if (qr != null && qr != "") {
      try {
        print(qr);
        await serverGate.postData(
          url: "attendance",
          body: {"id": qr},
          // onError: (b) {
          //   EasyLoading.dismiss();
          // },
          // onSuccess: (body) {
          //   EasyLoading.dismiss();
          //   Toast.show(body['data'], getlib.Get.context);
          //   return;
          // },
          headers: {"Authorization": "Bearer${userController.user.token}"},
        );
      } catch (e) {
        EasyLoading.dismiss();
        print(e);
      }
    }
    EasyLoading.dismiss();
    return;
  }

  _getHomeModel(String next, {Map<String, dynamic> parameter}) async {
    ServerGate serverGate = ServerGate();
    if (mounted && parameter != null)
      setState(() {
        _homeModel = null;
        _usersModels = null;
      });

    Response response = await serverGate.getData(
        url: "index",
        dontShowLoading: true,
        dontShowmsg: true,
        parameters: parameter,
        headers: {"Authorization": "Bearer${userController.user.token}"},
        nextURl: next);
    print(response.data.toString() + "00000000000000000000");
    // try {
    if (response != null &&
        response.data != null &&
        response.data['data'] != null)
      setState(() {
        _homeModel = HomeModel.fromJson(response.data['data']);
        try {
          _count = _homeModel.count;
          _attendance = _homeModel.attendances;
          _absence = _homeModel.absence;
        } catch (e) {
          _count = 0;
          _attendance = 0;
          _absence = 0;
        }
        if (next != null) {
          if (_homeModel.users.items == null ||
              _homeModel.users.items.length == 0)
            _refreshController.loadFailed();
          else
            _usersModels.addAll(_homeModel.users.items ?? []);
        } else
          _usersModels = _homeModel.users.items;
      });
    // } catch (e) {}
  }

  Map<String, dynamic> _parameters;
  HomeModel _homeModel;
  int _count;
  int _attendance;
  int _absence;
  List<Item> _usersModels;
  RefreshController _refreshController = RefreshController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: myAppBar(context, 'قائمة الحضور', ""),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage("assets/images/user.png"),
                    foregroundImage: userController.user.avatar == null &&
                            userController.user.image == null
                        ? null
                        : NetworkImage(userController.user.avatar ??
                            userController.user.image),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    userController.user == null ? "" : userController.user.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )),
              TextButton(
                onPressed: () async {
                  await removeAllShared();
                  getlib.Get.offAll(LoginScreen());
                },
                child: Text('تسجيل خروج'),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: width(context),
              height: height(context) * 0.3,
              color: AppColors.blue,
            ),
            Container(
              width: width(context),
              height: height(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    topCard(context, _count, _attendance ?? 0, _absence ?? 0),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: MidWidget(
                        searchFilter: (par) async {
                          if (mounted)
                            setState(() {
                              _parameters = par;
                            });
                          await _getHomeModel(null, parameter: par);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    Expanded(
                      child: MySmartRefresher(
                          scrollController: _scrollController,
                          refreshController: _refreshController,
                          faildText: "لا توجد نتائج أخرى",
                          onLoading: () async {
                            if (_homeModel != null &&
                                _homeModel.users.paginate.nextPageUrl != null &&
                                _homeModel.users.paginate.nextPageUrl != "")
                              await _getHomeModel(
                                  _homeModel.users.paginate.nextPageUrl,
                                  parameter: _parameters);

                            _refreshController.loadComplete();
                          },
                          onRefresh: () async {
                            setState(() {
                              _parameters = null;
                              _homeModel = null;
                              _usersModels = null;
                            });
                            await _getHomeModel(null);
                            _refreshController.refreshCompleted();
                          },
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: _homeModel == null
                                  ? [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: CircularProgressIndicator(),
                                      )
                                    ]
                                  : (_usersModels == null ||
                                          _usersModels.length == 0)
                                      ? [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: Text(
                                              "لا توجد نتائج",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ]
                                      : List.generate(
                                          _usersModels.length,
                                          (index) => listItem(
                                              context, _usersModels[index])),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height(context) * 0.04,
                  horizontal: width(context) * 0.04),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.blue),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () => counter().then(
                      (value) {
                        if (value < 0) {
                          print('object');
                        } else {
                          print(value.toString());
                        }
                      },
                    ),
                    icon: Icon(Icons.qr_code_scanner),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
