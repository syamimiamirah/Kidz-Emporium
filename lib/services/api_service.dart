import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kidz_emporium/config.dart';
import 'package:kidz_emporium/models/login_response_model.dart';
import 'package:kidz_emporium/models/register_request_model.dart';
import 'package:kidz_emporium/models/register_response_model.dart';
import 'package:kidz_emporium/models/login_request_model.dart';
import 'package:kidz_emporium/services/shared_service.dart';

class APIService{
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async{
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if(response.statusCode == 200){
      //shared
    await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    }else{
      return false;
    }

  }
  static Future<bool> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


// static Future<bool> registerUser(
  //     String name,
  //     String email,
  //     String phone,
  //     String role,
  //     String password,
  //     ){
  //   Map<String, String>requestHeaders = {'Content-Type': 'application/json'};
  //   var url = Uri.http(Config.apiURL, Config.registerAPI);
  //
  //   var response = await client.post(
  //       url,
  //   headers: requestHeaders,
  //   body: jsonEncode(
  //     {
  //       "name": name,
  //       "email": email,
  //       "phone": phone,
  //       "role": role,
  //       "password": password
  //     },
  //   ),
  //   );
  //}
}