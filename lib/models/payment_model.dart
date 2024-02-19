class PaymentModel {
  late int amount;
  late String currency;
  //late String status;
  late String paymentMethod;
  late String userId;
  final String? id;

  PaymentModel({
    required this.amount,
    required this.currency,
    //required this.status,
    required this.paymentMethod,
    required this.userId,
    this.id,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'amount' field as an integer
    final amount = json['amount'] as int? ?? 50;
    // Ensure 'paymentMethod' is a string
    final paymentMethod = json['paymentMethod'] is String
        ? json['paymentMethod']
        : ''; // Default value if not a string
    return PaymentModel(
      id: json['_id'],
      amount: amount,
      currency: json['currency'] ?? '',
      //status: json['status'] ?? '',
      paymentMethod: paymentMethod,
      userId: json['userId'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userId': userId,
      'amount': amount,
      'currency': currency,
      //'status': status,
      'paymentMethod': paymentMethod,
      '_id': id
    };

    /*if (id != null) {
      data['_id'] = id; // Include id in JSON if it's not null
    }*/

    return data;
  }
}

/*class PaymentMethod {
  final String id;
  final String brand;
  final String last4;

  PaymentMethod({required this.id, required this.brand, required this.last4});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      brand: json['brand'],
      last4: json['last4'],
    );
  }
}*/
