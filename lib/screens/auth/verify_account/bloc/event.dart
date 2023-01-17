import 'dart:io';

import 'package:flutter/cupertino.dart';

class VerifyEvents {}

class VerifyPostEvent extends VerifyEvents {
  late TextEditingController phoneController, code;
  late String countryCode;

  Map<String, dynamic> get body => {
        'phone': phoneController.text,
        'device_id': '111',
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'country_code': '966',
        "code": code.text
      };
  VerifyPostEvent() {
    phoneController = TextEditingController();
    countryCode = '';
    code = TextEditingController();
  }
}

class ResendEvents {}

class ResendPostEvent extends ResendEvents {
  late TextEditingController phoneController, passwordController;
  late String countryCode;

  Map<String, dynamic> get body => {
        'phone': phoneController.text,
        'device_id': '111',
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'country_code': '00966',
      };
  ResendPostEvent() {
    phoneController = TextEditingController();
    countryCode = '';
  }
}
