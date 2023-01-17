import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SignUpEvents {}

class SignUpPostEvent extends SignUpEvents {
  File? image;
  late TextEditingController phoneController, passwordController, userName,email,conifrmPassword;
  late String countryCode;

  Map<String, dynamic> get body => {
        'image': image != null
            ? MultipartFile.fromFileSync(image!.path,
                filename: image!.path.split("/").last)
            : null,
        'password': passwordController.text,
        'phone': phoneController.text,
        'type': 'user',
        'country_code': '966',
        "lat": 30.999999,
        "lng": 31.999999,
        "map_desc": "mansoura",
        "name": userName.text,
        // "email":email.text
      };
  SignUpPostEvent() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    countryCode = '';
    image = null;
    email = TextEditingController();
    userName = TextEditingController();
    conifrmPassword=TextEditingController();
  }
}
