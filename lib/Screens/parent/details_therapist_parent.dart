import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidz_emporium/models/therapist_model.dart';

import '../../contants.dart';
import '../../models/login_response_model.dart';
import '../../services/api_service.dart';
import '../../utils.dart';

class TherapistDetailParentPage extends StatefulWidget {
  final LoginResponseModel userData;
  final String therapistId;

  const TherapistDetailParentPage(
      {Key? key, required this.userData, required this.therapistId})
      : super(key: key);

  @override
  _TherapistDetailParentPageState createState() => _TherapistDetailParentPageState();
}

class _TherapistDetailParentPageState extends State<TherapistDetailParentPage> {
  late String therapistName = "";
  late String specialization = "";
  late DateTime hiringDate = DateTime.now();
  late String aboutMe = "";
  late String userId;

  @override
  void initState() {
    super.initState();
    if (widget.userData != null && widget.userData.data != null) {
      print("userData: ${widget.userData.data!.id}");
      userId = widget.userData.data!.id;
      fetchTherapistDetails();
    } else {
      // Handle the case where userData or userData.data is null
      print("Error: userData or userData.data is null");
    }
  }

  Future<void> fetchTherapistDetails() async {
    try {
      TherapistModel? therapist = await APIService.getTherapistDetails(widget.therapistId);

      if (therapist != null) {
        // Update UI with fetched reminder details
        setState(() {
          therapistName = therapist.therapistName;
          hiringDate = Utils.parseStringToDateTime(therapist.hiringDate);
          specialization = therapist.specialization;
          aboutMe = therapist.aboutMe;
          // Update other fields as needed
        });
      } else {
        // Handle case where reminder is null
        print('Therapist details not found');
      }
    } catch (error) {
      print('Error fetching therapist details: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapist Details'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/medical_team.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name: ${therapistName ?? 'N/A'}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hiring Date: ${DateFormat('yyyy-MM-dd').format(hiringDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Specialization: ${specialization ?? 'N/A'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'About Me: ${aboutMe ?? 'N/A'}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
