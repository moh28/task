import 'package:flutter/cupertino.dart';

class ForgetPasswordEvents {}

class ForgetPasswordPostEvent extends ForgetPasswordEvents {
  late TextEditingController phoneController;
  late String countryCode;

  Map<String, dynamic> get body => {
        'phone': phoneController.text,
        'country_code': '00966',
      };
  ForgetPasswordPostEvent() {
    phoneController = TextEditingController();
    countryCode = '';
  }
}
