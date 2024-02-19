class BookingModel {
  late String userId;
  final String? id;
  String therapistId;
  String childId;
  late String fromDate;
  late String toDate;
  String? paymentId;

  BookingModel({
    required this.userId,
    this.id,
    required this.therapistId,
    required this.childId,
    required this.fromDate,
    required this.toDate,
    this.paymentId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'],
      userId: json['userId'] ?? '',
      therapistId: json['therapistId'] ?? '',
      childId: json['childId'] ?? '',
      fromDate: json['fromDate'] ?? '', // Provide a default value or handle null
      toDate: json['toDate'] ?? '',  // Add null check and handle null case
      paymentId: json['paymentId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userId': userId,
      'therapistId': therapistId,
      'childId': childId,
      'fromDate': fromDate,
      'toDate': toDate,
      //'status': status,
      'paymentId': paymentId,
    };

    if (id != null) {
      data['_id'] = id; // Include id in JSON if it's not null
    }

    return data;
  }
}
