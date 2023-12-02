import 'package:flutter/material.dart';
import 'package:kidz_emporium/Screens/parent/create_reminder_parent.dart';
import 'package:kidz_emporium/widget/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/side_menu.dart';
import '../../contants.dart';
import '../../models/login_response_model.dart';

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

  @override
  void initState(){
    super.initState();
    _selectedDate = _focusedDay;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(userData: widget.userData),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("View Reminder ${widget.userData.data?.name ?? 'User'}"),
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