class ReminderModel {
  late final String eventName;
  late final String details;
  late final String fromDate; // Update this to String
  late final String toDate; // Update this to String
  late final String userId;

  ReminderModel({
    required this.eventName,
    required this.details,
    required this.fromDate,
    required this.toDate,
    required this.userId,
  });

  ReminderModel.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    details = json['details'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['details'] = this.details;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['userId'] = this.userId;
    return data;
  }
}
