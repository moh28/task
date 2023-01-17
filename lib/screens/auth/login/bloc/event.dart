import 'dart:io';

import 'package:flutter/cupertino.dart';

class LogInEvents {}

class LogInPostEvent extends LogInEvents {
  late TextEditingController phoneController,passwordController;
  late String countryCode;

  Map<String, dynamic> get body  => {
    'phone': phoneController.text,
    'password': passwordController.text,
    'device_id': '111',
    'device_type': Platform.isAndroid?'android':'ios',
    'country_code':'00966',
  };
  LogInPostEvent() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    countryCode = '';
  }
}