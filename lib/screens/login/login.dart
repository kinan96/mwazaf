import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getlib;
import 'package:mwazaf_app/customWidget/myBottom.dart';
import 'package:mwazaf_app/customWidget/myTextForm.dart';
import 'package:mwazaf_app/customWidget/serverGate.dart';
import 'package:mwazaf_app/customWidget/shared_preferences_helper.dart';
import 'package:mwazaf_app/customWidget/validators.dart';
import 'package:mwazaf_app/screens/home/home.dart';
import 'package:mwazaf_app/screens/login/model.dart';
import 'package:mwazaf_app/style/colors.dart';
import 'package:mwazaf_app/style/sizes.dart';
import 'userController.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _pass = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    _splash();
    super.initState();
  }

  _splash() async {
    String loginJson = await getSharedStringOfKey("login");
    if (loginJson != null) {
      LoginModel model = loginModelFromJson(loginJson);
      if (model.data.phone != null && model.password != null)
        await _login(model.data.phone, model.password);
    } else
      EasyLoading.dismiss();
  }

  _login(String phone, password) async {
    ServerGate serverGate = ServerGate();
    Response resp = await serverGate.postData(
      body: {"phone": phone, "password": password},
      url: "login",
    );
    LoginModel loginModel;
    if (resp.data['data'] != null && resp.data['data'].length > 0)
      loginModel = LoginModel.fromJson(resp.data, password: password);
    if (loginModel != null &&
        (loginModel.value || resp.data['value'] == null)) {
      userController.changeUser(loginModel.data);
      await addSharedString("login", loginModelToJson(loginModel));
      getlib.Get.off(Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.blue,
        body: Container(
          width: width(context),
          height: height(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width(context) * 0.025),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    SizedBox(
                      height: height(context) * 0.25,
                    ),
                    Image.asset('assets/images/user.png'),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    Text(
                      'مرحبا بعودتك',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'سجل الدخول إلى حسابك لإدارة الحضور والانصراف',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    MyTextFormField(
                      hint: 'رقم الهاتف',
                      controller: _phone,
                      validator: mobileValidate,
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    MyTextFormField(
                      hint: 'كلمة المرور',
                      controller: _pass,
                      isPassword: true,
                      validator: passwordValidate,
                      icon: Icons.lock,
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    MyBottom(
                      function: () async {
                        if (!_form.currentState.validate()) return;
                        await _login(_phone.text, _pass.text);
                      },
                      title: 'تسجيل الدخول',
                    ),
                    SizedBox(
                      height: height(context) * 0.025,
                    ),
                    Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
