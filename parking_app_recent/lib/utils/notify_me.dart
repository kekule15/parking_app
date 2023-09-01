import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_app/style/appColors.dart';

class NotifyMe {
  static showAlert(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showScaffoldAlert(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
      child: Text(message,
          style: Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
              fontSize: 13.sp,
              color: Theme.of(context).scaffoldBackgroundColor)),
    )));
  }

  //Notification Sending Side Using Dio flutter Library to make http post request

  static Future<void> sendNotification(
      {required String sender, required String content}) async {
    //var token = PreferenceUtils.getString(key: 'userToken');

    final data = {
      "to": "token",
      "priority": "high",
      "notification": {"title": sender, "body": content, "sound": "default"},
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
    };

    final headers = {
      //'content-type': 'application/json',
      'Authorization': ''
    };

    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: headers,
    );

    try {
      final response = await Dio(options)
          .post('https://fcm.googleapis.com/fcm/send', data: json.encode(data));

      if (response.statusCode == 200) {
        print(response.data);
        // Fluttertoast.showToast(msg: 'Request Sent');
      } else {
        print('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      print('exception $e');
    }
  }
}
