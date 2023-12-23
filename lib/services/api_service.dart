import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kidz_emporium/config.dart';
import 'package:kidz_emporium/models/child_model.dart';
import 'package:kidz_emporium/models/login_response_model.dart';
import 'package:kidz_emporium/models/register_request_model.dart';
import 'package:kidz_emporium/models/register_response_model.dart';
import 'package:kidz_emporium/models/login_request_model.dart';
import 'package:kidz_emporium/models/reminder_model.dart';
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
      final Map<String, dynamic> data = json.decode(response.body);

      // Access the _id
      //final String userId = data['data']['_id']; // Update this line
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
      final Map<String, dynamic> data = json.decode(response.body);
      // Print or log relevant information
      print("Response data: $data");
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }


  static Future<ReminderModel?> createReminder(ReminderModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.createReminderAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return ReminderModel.fromJson(responseData);
    } else {
      throw Exception('Failed to create reminder');
    }
  }

  static Future<List<ReminderModel>> getReminder(String userId) async {
    var url = Uri.http(Config.apiURL, Config.getReminderAPI, {'userId': userId});
    print("Request URL: $url");

    try {
      var response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10));


      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData['status'] == true && responseData.containsKey('success')) {
          List<ReminderModel> reminders = (responseData['success'] as List)
              .map((json) => ReminderModel.fromJson(json))
              .toList();

          return reminders;
        } else {
          print("Invalid response format. Expected 'status' true and 'success' key.");
          return [];
        }
      } else {
        print("Failed to fetch reminders. Status code: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error fetching reminders: $error");
      return [];
    }
  }

  static Future<bool> deleteReminder(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.deleteReminderAPI);  // Change '_id' to 'id'
    print("Request URL: $url");

    try {
      var response = await client.delete(
        url,
        headers: requestHeaders,
        body: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Failed to delete reminder. Status code: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      print("Error deleting reminder: $error");
      return false;
    }
  }

  static Future<ReminderModel?> getReminderDetails(String id) async {
    try {
      var url = Uri.http(Config.apiURL, '${Config.getReminderDetailsAPI}/$id');
      print("Request URL: $url");

      var response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        return responseData != null ? ReminderModel.fromJson(responseData['success']) : null;
      } else {
        print('Error response body: ${response.body}');
        throw Exception('Failed to get reminder details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error getting reminder details: $error');
      throw error;
    }
  }

  // Add this method to your APIService class
  static Future<bool> updateReminder(String id, ReminderModel updatedModel) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, '${Config.updateReminderAPI}/$id'); // Adjust the API endpoint
    print("Request URL: $url");
    print("id: $id");
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode({'_id': id, 'updatedData': updatedModel.toJson()}),
    );

    if (response.statusCode == 200) {
      print("success");
      return true;
    } else {
      print("Failed to update reminder. Status code: ${response.statusCode}");
      return false;
    }
  }

  //child
  static Future<ChildModel?> createChild(ChildModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.createChildAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return ChildModel.fromJson(responseData);
    } else {
      throw Exception('Failed to create child');
    }
  }

}