import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getlib;
import 'package:mwazaf_app/screens/login/login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toast/toast.dart';
import 'shared_preferences_helper.dart';

class ServerGate {
  final String baseUrl = "https://amnei.devest.co/api";
  bool isUploading;
  ServerGate({
    this.isUploading,
  });
  // Dio dio = Dio();
  Dio get dio {
    var _dio = Dio();
    // _dio.options.sendTimeout = 60000;
    // _dio.options.receiveTimeout = 60000;

    return _dio;
  }

  Future<Response> postData({
    String url,
    Map<String, dynamic> headers,
    bool dontShowmsg,
    bool dontShowLoading,
    Map<String, dynamic> body,
    Function(Map<String, dynamic> body) onSuccess,
    Function(Map<String, dynamic> body) onError,
  }) async {
    // remove nulls from body
    body.removeWhere(
      (key, value) => body[key] == null || body[key] == "",
    );

    try {
      if (dontShowLoading == null || dontShowLoading == false)
        EasyLoading.show();
      Response response = await dio.post(
        "$baseUrl/$url",
        data: body,
        // onSendProgress: (count, total) {
        //   progressRatioController.updateRatio((count / total) * 100);
        // },
        options: Options(
            headers: headers,
            validateStatus: (status) {
              if (status == 401) {
                removeAllShared();
                getlib.Get.offAll(LoginScreen());
              }
              return true;
            }),
      );
      print(response.data);
      if (dontShowLoading == null || dontShowLoading == false)
        EasyLoading.dismiss();
      if (!(dontShowmsg != null && dontShowmsg == true)) {
        if ((response.data['msg'] != null && response.data['msg'] != "") ||
            (response.data['msgs'] != null && response.data['msgs'] != ""))
          Toast.show(response.data['msg'] ?? response.data['msgs'],
              getlib.Get.context);
      }
      print(response.statusCode);
      if (response.statusCode == 200 && onSuccess != null)
        try {
          await onSuccess(response.data);
        } catch (e) {
          print(e);
        }
      else if (response.statusCode == 401) {
        removeAllShared();
        getlib.Get.offAll(LoginScreen());
      } else {
// on error
        if (onError != null)
          try {
            await onError(response.data);
          } catch (e) {
            print(e);
          }
      }
      return response;
    } on DioError catch (e) {
      print(e);
      // Toast.show("توجد مشكلة في الإتصال", getlib.Get.context);
      EasyLoading.dismiss();

      return null;
    }
  }

// ------- UPDATE DATA TO SERVER -------//
  Future<Response> updateData({
    String url,
    Map<String, dynamic> headers,
    bool dontShowmsg,
    Map<String, dynamic> body,
    bool dontShowLoading,
    Function(Map<String, dynamic> body) onSuccess,
    Function(Map<String, dynamic> body) onError,
  }) async {
    // remove nulls from body
    body.removeWhere(
      (key, value) => body[key] == null || body[key] == "",
    );

    try {
      if (dontShowLoading == null || dontShowLoading == false)
        EasyLoading.show();

      Response response = await dio.put(
        "$baseUrl/$url",
        data: body,
        // onSendProgress: (count, total) {
        //   progressRatioController.updateRatio((count / total) * 100);
        // },
        options: Options(
            headers: headers,
            validateStatus: (status) {
              if (status == 401) {
                removeAllShared();
                getlib.Get.offAll(LoginScreen());
              }
              return true;
            }),
      );
      if (dontShowLoading == null || dontShowLoading == false)
        EasyLoading.dismiss();
      if (!(dontShowmsg != null && dontShowmsg == true)) {
        if ((response.data['msg'] != null && response.data['msg'] != "") ||
            (response.data['msgs'] != null && response.data['msgs'] != ""))
          Toast.show(response.data['msg'] ?? response.data['msgs'],
              getlib.Get.context);
      }
      if (response.statusCode == 200 && onSuccess != null)
        await onSuccess(response.data);
      else if (response.statusCode == 401) {
        removeAllShared();
        getlib.Get.offAll(LoginScreen());
      } else {
// on error
        if (onError != null) await onError(response.data);
      }
      return response;
    } on DioError catch (err) {
      // if (err.type == DioErrorType.CONNECT_TIMEOUT)
      // Toast.show("توجد مشكلة في الإتصال", getlib.Get.context);
      EasyLoading.dismiss();

      print(err);
      return null;
    }
  }

  // ------ getlib.GET DATA fromMap SERVER -------//
  Future<Response> getData({
    String url,
    String nextURl,
    Map<String, dynamic> headers,
    bool dontShowmsg,
    bool dontShowLoading,
    Map<String, dynamic> body,
    Function(Map<String, dynamic> body) onSuccess,
    Function(Map<String, dynamic> body) onError,
  }) async {
    try {
      if (dontShowLoading == null || dontShowLoading == false)
        EasyLoading.show(status: '');
      Response response = await dio.get(
        nextURl != null && nextURl != "" ? nextURl : "$baseUrl/$url",
        options: Options(
            headers: headers,
            validateStatus: (status) {
              if (status == 401) {
                removeAllShared();
                getlib.Get.offAll(LoginScreen());
              }
              return true;
            }),
      );

      if (dontShowLoading == null || dontShowLoading == false)
        EasyLoading.dismiss();
      if (!(dontShowmsg != null && dontShowmsg == true)) {
        if ((response.data['msg'] != null && response.data['msg'] != "") ||
            (response.data['msgs'] != null && response.data['msgs'] != ""))
          Toast.show(response.data['msg'] ?? response.data['msgs'],
              getlib.Get.context);
      }
      if (response.statusCode == 200 && onSuccess != null)
        await onSuccess(response.data);
      else if (response.statusCode == 401) {
        removeAllShared();
        getlib.Get.offAll(LoginScreen());
      } else {
// on error
        if (onError != null) await onError(response.data);
      }
      return response;
    } on DioError catch (err) {
      print(err);
      // Toast.show("توجد مشكلة في الإتصال", getlib.Get.context);
      EasyLoading.dismiss();
      return null;
    }
  }

  // -------- HANDLE ERROR ---------//
}

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: progressRatioController.progressRatioStream,
      initialData: 0,
      builder: (context, ratio) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text(ratio.data.toStringAsFixed(1) + "%")
          ],
        );
      },
    );
  }
}

class ProgressRatioController {
  BehaviorSubject<double> _ratioCTL = BehaviorSubject<double>();
  Function(double) get updateRatio => _ratioCTL.sink.add;
  double get progressRatio => _ratioCTL.value;
  Stream<double> get progressRatioStream => _ratioCTL.stream;

  dispose() {
    _ratioCTL.close();
  }
}

ProgressRatioController progressRatioController = ProgressRatioController();
