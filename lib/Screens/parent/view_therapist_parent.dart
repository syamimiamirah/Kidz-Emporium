import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidz_emporium/models/therapist_model.dart';

import '../../contants.dart';
import '../../models/login_response_model.dart';

class ViewTherapistParentPage extends StatefulWidget {
  final LoginResponseModel userData;
  final List<TherapistModel> therapists; // Pass the list of therapists

  const ViewTherapistParentPage({Key? key, required this.userData, required this.therapists})
      : super(key: key);

  @override
  _viewTherapistParentPageState createState() => _viewTherapistParentPageState();
}

class _viewTherapistParentPageState extends State<ViewTherapistParentPage> {
  List<TherapistModel> filteredTherapists = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTherapists = widget.therapists;
  }

  void _filterTherapists(String query) {
    setState(() {
      filteredTherapists = widget.therapists
          .where((therapist) =>
          therapist.therapistName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _resetSearch() {
    setState(() {
      filteredTherapists = widget.therapists;
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapists List'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetSearch,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: _filterTherapists,
              decoration: InputDecoration(
                labelText: 'Search by Name',
              ),
            ),
            SizedBox(height: 10),
            Text(
              "List of Therapists",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTherapists.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.orange[100]!.withOpacity(0.8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage('assets/images/medical_team.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            '${filteredTherapists[index].therapistName ?? 'N/A'}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Hiring Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(filteredTherapists[index].hiringDate as String))}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Specialization: ${filteredTherapists[index].specialization ?? 'N/A'}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'About Me:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${filteredTherapists[index].aboutMe ?? 'N/A'}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
