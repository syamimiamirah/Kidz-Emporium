import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidz_emporium/Screens/parent/create_reminder_parent.dart';
import 'package:kidz_emporium/models/reminder_model.dart';
import 'package:kidz_emporium/models/reminder_model.dart';
import 'package:kidz_emporium/services/api_service.dart';
import 'package:kidz_emporium/widget/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/side_menu.dart';
import '../../contants.dart';
import '../../models/login_response_model.dart';
import '../../models/reminder_model.dart';

class ViewReminderParentPage extends StatefulWidget{
  final LoginResponseModel userData;
  const ViewReminderParentPage({Key? key, required this.userData}) : super(key: key);


  @override
  _viewReminderParentPageState createState() => _viewReminderParentPageState();
}
class _viewReminderParentPageState extends State<ViewReminderParentPage> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, dynamic> mySelectedEvents = {};

  @override
  void initState(){
    super.initState();
    _selectedDate = _focusedDay;
    _loadReminders(widget.userData.data!.id);
  }
  Future<void> _loadReminders(String userId) async {
    try {
      List<ReminderModel> reminders = await APIService.getReminder(widget.userData.data!.id);

      print('Number of reminders: ${reminders.length}');

      for (var reminderData in reminders) {
        String dateKey = DateFormat('yyyy-MM-dd').format(DateTime.parse(reminderData.fromDate as String));
        String title =  reminderData.eventName;
        String details = reminderData.details;
        //DateTime fromDate = DateTime.parse(reminderData.fromDate as String);
        print('Date Key: $dateKey, Details: $details');

        mySelectedEvents[dateKey] ??= [];
        mySelectedEvents[dateKey]!.add({'title': title, 'details': details});
      }

      setState(() {});
    } catch (error) {
      print('Error loading reminders: $error');
      // Handle the error as needed
    }
  }


  List _listOfDayEvents(DateTime dateTime){
    if(mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null){
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(userData: widget.userData),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("View Reminder"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2023),
              lastDay: DateTime(2025),
              calendarFormat: _calendarFormat,

              onDaySelected: (selectedDay, focusedDay){
                if(!isSameDay(_selectedDate, selectedDay)){
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },

              selectedDayPredicate: (day){
                return isSameDay(_selectedDate, day);
              },

              onFormatChanged: (format){
                if(_calendarFormat != format){
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },

              onPageChanged: (focusedDay){
                _focusedDay = focusedDay;
              },
                eventLoader: _listOfDayEvents,
            ),
            Expanded(
              child: _listOfDayEvents(_selectedDate!).isNotEmpty
                  ? ListView.builder(
                itemCount: _listOfDayEvents(_selectedDate!).length,
                itemBuilder: (context, index) {
                  String reminderTitle = _listOfDayEvents(_selectedDate!)[index]['title'];
                  String reminderDetails = _listOfDayEvents(_selectedDate!)[index]['details'];


                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Event Name: $reminderTitle'),
                        Text('Details: $reminderDetails'),
                        //Text('From Date: $fromDate'),
                      ],
                    ),
                  );
                },
              )
                  : Center(child: Text('No reminders for selected date')),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(
            builder: (context) =>  CreateReminderParentPage(userData: widget.userData)),
        );
          },
        child: Icon(
            Icons.add,
            color: Colors.black),
        backgroundColor: kPrimaryColor,
      ),

    );
  }

}