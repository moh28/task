import 'dart:io';

import 'package:flutter/cupertino.dart';

class ResedPasswordEvents {}

class ResedPasswordPostEvent extends ResedPasswordEvents {
  late TextEditingController phoneController,code,password,confirm;
  late String countryCode;

  Map<String, dynamic> get body  => {
    'phone': phoneController.text,
    'code': code.text,
    'password': password.text,
    'country_code':'00966',
  };
  ResedPasswordPostEvent() {
    phoneController = TextEditingController();
    code = TextEditingController();
    password =TextEditingController();
    confirm =TextEditingController();
    countryCode = '';
  }
}