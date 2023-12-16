import 'dart:convert';

ReminderResponseModel reminderResponseModel(String str) =>
    ReminderResponseModel.fromJson(json.decode(str));

class ReminderResponseModel {
  ReminderResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data? data;

  ReminderResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}
class Data {
  Data({
    required this.eventName,
    required this.details,
    required this.fromDate,
    required this.toDate,
    required this.userId,
    required this.id,
  });
  late final String eventName;
  late final String details;
  late final String fromDate; // Update this to String
  late final String toDate; // Update this to String
  late final String userId;
  late final String id;

  Data.fromJson(Map<String, dynamic> json){
    eventName = json['eventName'];
    details = json['details'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['details'] = this.details;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['userId'] = this.userId;
    data['id'] = id;
    return data;


  }
}