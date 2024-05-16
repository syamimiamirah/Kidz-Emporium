import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidz_emporium/models/therapist_model.dart';
import '../../contants.dart';
import '../../services/api_service.dart';
import '../../models/user_model.dart';

class ViewTherapistAvailabilityPage extends StatefulWidget {
  final DateTime fromDate;
  final DateTime toDate;

  const ViewTherapistAvailabilityPage({
    Key? key,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);

  @override
  _ViewTherapistAvailabilityPageState createState() => _ViewTherapistAvailabilityPageState();
}

class _ViewTherapistAvailabilityPageState extends State<ViewTherapistAvailabilityPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late DateTime selectedFromDate;
  late DateTime selectedToDate;
  List<TherapistModel> availableTherapists = [];
  List<UserModel> users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedFromDate = widget.fromDate;
    selectedToDate = widget.toDate;
    _fetchAvailabilityAndUsers(selectedFromDate, selectedToDate);
  }

  void _fetchAvailabilityAndUsers(DateTime fromDate, DateTime toDate) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetching available therapists and all users in parallel
      final results = await Future.wait([
        APIService.getAvailableTherapists(fromDate, toDate),
        APIService.getAllUsers(),
      ]);

      setState(() {
        availableTherapists = results[0] as List<TherapistModel>;
        users = results[1] as List<UserModel>;
      });
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      // Define a theme for the date picker
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor, // Change the primary color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedFromDate),
        // Define a theme for the time picker
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: kPrimaryColor, // Change the primary color
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        setState(() {
          selectedFromDate = DateTime(
              pickedDate.year, pickedDate.month, pickedDate.day,
              pickedTime.hour, pickedTime.minute);
        });
        _fetchAvailabilityAndUsers(selectedFromDate, selectedToDate);
      }
    }
  }


  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedToDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor, // Change the primary color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedToDate),

        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: kPrimaryColor, // Change the primary color
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        setState(() {
          selectedToDate = DateTime(
              pickedDate.year, pickedDate.month, pickedDate.day,
              pickedTime.hour, pickedTime.minute);
        });
        _fetchAvailabilityAndUsers(selectedFromDate, selectedToDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapist Availability'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: _viewTherapistAvailabilityUI(context),
      ),
    );
  }

  Widget _viewTherapistAvailabilityUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Select Date and Time Range:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildDateSelectionRow(context),
          const SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : availableTherapists.isEmpty
                ? Center(child: Text('No therapists available'))
                : ListView.builder(
              itemCount: availableTherapists.length,
              itemBuilder: (context, index) {
                final therapist = availableTherapists[index];
                final user = users.firstWhere(
                      (user) => user.id == therapist.therapistId!,
                  orElse: () =>
                      UserModel(
                        id: '',
                        name: 'Unknown',
                        email: '',
                        password: '',
                        phone: '',
                        role: 'Therapist',
                      ),
                );

                return InkWell(
                  onTap: () {
                    // Handle tap event if needed
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          user.name ?? 'Unknown',
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          therapist.specialization ?? 'No specialization',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: _buildAvailabilityIndicator(true),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildAvailabilityIndicator(bool isAvailable) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isAvailable ? 'Available' : 'Not Available',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _buildDateSelectionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDateSelector(
          context: context,
          label: 'From Date & Time',
          date: selectedFromDate,
          onTap: () => _selectFromDate(context),
        ),
        _buildDateSelector(
          context: context,
          label: 'To Date & Time',
          date: selectedToDate,
          onTap: () => _selectToDate(context),
        ),
      ],
    );
  }

  Widget _buildDateSelector({
    required BuildContext context,
    required String label,
    required DateTime date,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.calendar_today, color: Theme
                  .of(context)
                  .primaryColor),
              SizedBox(width: 10),
              Container(
                width: 150, // Adjust the width as needed
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(date),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.access_time, color: Theme
                  .of(context)
                  .primaryColor),
              SizedBox(width: 10),
              Container(
                width: 150, // Adjust the width as needed
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    DateFormat('HH:mm').format(date),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}