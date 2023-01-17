
class UserDataModel {
  late final int id;
  late final String name;
  late final String phone;
  late final String email;
  late final String countryCode;
  late final String image;
  late final String fullPhone;
  late final String token;
  late final String lang;
  late final String type;
  late final String lat;
  late final String lng;
  late final String mapDesc;
  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'';
    phone = json['phone']??'';
    email = json['email']??'';
    countryCode = json['country_code']??'';
    image=json['image']??'';
    fullPhone = json['full_phone']??'';
    token = json['token']??'';
    lang=json['lang']??'';
    type=json['type']??'';
    lat=json['lat']??'';
    lng=json['lng']??'';
    mapDesc=json['map_desc']??'';
  }
}

