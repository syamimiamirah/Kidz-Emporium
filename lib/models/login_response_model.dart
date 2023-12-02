import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {

  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data? data;

  LoginResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null; // Handle null 'data'
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data?.toJson(); // Use the safe navigation operator '?'
    return _data;
  }
}

class Data {
  Data({
    required this.email,
    required this.name,
    required this.id,
    required this.token,
  });
  late final String email;
  late final String name;
  late final String id;
  late final String? token;

  Data.fromJson(Map<String, dynamic> json){
    email = json['email'];
    name = json['name'];
    id = json['_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['name'] = name;
    _data['_id'] = id;
    _data['token'] = token;
    return _data;
  }
}
