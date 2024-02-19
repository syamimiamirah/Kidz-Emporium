import 'package:flutter/material.dart';
import 'package:kidz_emporium/config.dart';
import 'package:flutter/services.dart'; // Import this package
import 'package:kidz_emporium/services/api_service.dart';

import '../../contants.dart';
import '../../models/booking_model.dart';
import '../../models/login_response_model.dart';
import '../../models/payment_model.dart';
import '../../utils.dart';

class PaymentPage extends StatefulWidget {
  final LoginResponseModel userData;
  final String? selectedTherapist;
  final String? selectedChild;
  final DateTime fromDate;
  final DateTime toDate;

  const PaymentPage({Key? key,
    required this.userData,
    required this.selectedTherapist,
    required this.selectedChild,
    required this.fromDate,
    required this.toDate,}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int? paymentAmount;
  String? paymentId;
  late String userId;// Fixed payment amount in Malaysian Ringgit

  // Define input formatters
  //final cardNumberFormatter = _CardNumberInputFormatter(); // Custom input formatter for card number
  final numericFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  final cvvFormatter = LengthLimitingTextInputFormatter(3); // Limit CVV to 3 digits
  final expirationDateFormatter = _ExpirationDateInputFormatter(); // Custom input formatter for expiration date

  // Controllers
  final cardNumberController = TextEditingController();
  final expirationDateController = TextEditingController();
  final cvvController = TextEditingController();

  // Error states
  bool cardNumberError = false;
  bool _isProcessingPayment = false;
  bool _isPaymentSuccessful = false;

  @override
  void initState(){
    super.initState();
    paymentAmount = 50;
    if(widget.userData != null && widget.userData.data != null){
      print("userData: ${widget.userData.data!.id}");
      userId = widget.userData.data!.id;
    }else {
      // Handle the case where userData or userData.data is null
      print("Error: userData or userData.data is null");
      userId = '';
    }
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    cardNumberController.dispose();
    expirationDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Credit/Debit Card Payment',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please enter your credit/debit card information to proceed with the payment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),

                      Text(
                        'RM 50.00',
                        // Display fixed payment amount in Malaysian Ringgit
                        style: TextStyle(
                          fontSize: 24,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Card Details:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Card Number ", style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold)
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          _CardNumberInputFormatter(),
                          // Custom input formatter for card number
                        ],
                        keyboardType: TextInputType.number,
                        maxLength: 19,
                        // Maximum length for card number with spaces
                        decoration: InputDecoration(
                          hintText: 'XXXX XXXX XXXX XXXX',
                          border: OutlineInputBorder(),
                          counterText: '', // Hide the counter text
                          errorText: cardNumberError
                              ? 'Please enter a valid card number'
                              : null,
                        ),
                        style: TextStyle(fontSize: 16),
                        controller: cardNumberController,
                        onChanged: (value) {
                          setState(() {
                            cardNumberError =
                                value.isNotEmpty && !_isValidCardNumber(value);
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                          children: [
                            Expanded(
                              child: Text("Expire Date ", style: TextStyle(
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold)
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text("Security Code ", style: TextStyle(
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold)
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: TextFormField(
                                inputFormatters: [expirationDateFormatter],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'MM/YY',
                                  border: OutlineInputBorder(),
                                ),
                                controller: expirationDateController,
                                minLines: 1,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: TextFormField(
                                inputFormatters: [
                                  cvvFormatter,
                                  numericFormatter
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'CVV',
                                  border: OutlineInputBorder(),
                                ),
                                controller: cvvController,
                                minLines: 1,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _isProcessingPayment
                      ? null // Disable the button while processing payment
                      : _isPaymentSuccessful
                      ? null // Disable the button if payment is already successful
                      : () {
                    // Process payment if not already successful
                    _processPayment();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _isPaymentSuccessful ? Colors.green : kPrimaryColor, // Change button color to green if payment is successful
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: _isProcessingPayment
                      ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : Text(
                    _isPaymentSuccessful ? 'Paid' : 'Pay RM50.00', // Change button text to "Paid" if payment is successful
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (paymentAmount == null) {
      print('Error: Payment amount is null');
      return;
    }

    print("Payment: RM ${paymentAmount}.00");

    setState(() {
      _isProcessingPayment = true;
    });
    PaymentModel model = PaymentModel(
      amount: 50,
      currency: 'MYR',
      paymentMethod: 'pm_card_visa',
      userId: userId,
    );
    APIService.createPayment(model).then((response){
      if (response != null) {
        _showPaymentSuccessDialog(); // Invoke the success callback
        setState(() {
          _isPaymentSuccessful = true;
        });
      } else {
        _showPaymentFailedDialog();
      }
      paymentId = response?.id;
      print(response?.id);
      print(paymentId);
      _createBooking();
    }).catchError((error) {
      _showErrorDialog(
          'An error occurred while processing your payment. Please try again later.');
      print('Error processing payment: $error');
    }).whenComplete(() {
      setState(() {
        _isProcessingPayment = false;
      });
    });
  }




  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment was successful.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentFailedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Failed'),
          content: Text('Your payment failed. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _createBooking() async {
    //print("Payment id: $paymentId");

      BookingModel? response = await APIService.createBooking(
        userId: widget.userData.data!.id,
        therapistId: widget.selectedTherapist!,
        childId: widget.selectedChild!,
        fromDate: Utils.formatDateTimeToString(widget.fromDate),
        toDate: Utils.formatDateTimeToString(widget.toDate),
        paymentId: paymentId!, // Since payment is handled separately, set paymentId to null
      );

      if (response != null) {
        print("mantap");
      } else {
        // Handle failed booking creation
      }
     /*catch (error) {
      _showErrorDialog(
          'An error occurred while processing your booking. Please try again later.');
      print('Error creating booking: $error');
    }*/
  }
}


// Simulate payment logic (Replace this with actual payment logic)
  bool _simulatePayment(String cardNumber, String expireDate, String cvv) {
    // Check if all fields are not empty and the expiration date is valid
    if (cardNumber.isNotEmpty && expireDate.isNotEmpty && cvv.isNotEmpty) {
      // Split expiration date into month and year
      List<String> dateParts = expireDate.split('/');
      if (dateParts.length == 2) {
        int month = int.tryParse(dateParts[0]) ?? 0;
        int year = int.tryParse(dateParts[1]) ?? 0;

        // Validate expiration date format (MM/YY)
        if (month >= 1 && month <= 12 && year >= 0 && year <= 99) {
          // Expiration date is valid
          return true;
        }
      }
    }
    // If any condition fails, return false
    return false;
}

// Custom input formatter for expiration date (MM/YY)
class _ExpirationDateInputFormatter extends TextInputFormatter {
  @override

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length > 5) {
      return oldValue; // Prevents entering more than 5 characters
    }
    if (text.length == 3 && newValue.selection.end == 3) {
      // Adds a '/' after entering 2 characters (MM)
      return newValue.copyWith(
        text: '${text.substring(0, 2)}/',
        selection: TextSelection.collapsed(offset: 3),
      );
    }
    return newValue;
  }
}
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    List<String> parts = [];

    for (int i = 0; i < newText.length; i += 4) {
      if (i + 4 <= newText.length) {
        parts.add(newText.substring(i, i + 4));
      } else {
        parts.add(newText.substring(i));
      }
    }

    return TextEditingValue(
      text: parts.join(' ').trim(),
      selection: TextSelection.collapsed(offset: parts.join(' ').length),
    );
  }
}


bool _isValidCardNumber(String value) {
  return value.replaceAll(' ', '').length == 16; // Check if card number has exactly 16 digits
}


