class TherapistModel {
  late String therapistName;
  late String specialization;
  late String hiringDate;
  late String aboutMe;
  late String userId;
  final String? id;

  TherapistModel({
    required this.therapistName,
    required this.specialization,
    required this.hiringDate,
    required this.aboutMe,
    required this.userId,
    this.id, // Nullable id field
  });

  factory TherapistModel.fromJson(Map<String, dynamic> json) {
    return TherapistModel(
      id: json['_id'],
      therapistName: json['therapistName'] ?? '', // Provide a default value or handle null
      specialization: json['specialization'] ?? '', // Provide a default value or handle null
      hiringDate: json['hiringDate'] ?? '', // Provide a default value or handle null
      aboutMe: json['aboutMe'] ?? '', // Provide a default value or handle null
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'therapistName': therapistName,
      'specialization': specialization,
      'hiringDate': hiringDate,
      'aboutMe': aboutMe,
      'userId': userId,
      '_id': id,
    };

    if (id != null) {
      data['_id'] = id; // Include id in JSON if it's not null
    }

    return data;
  }
}
