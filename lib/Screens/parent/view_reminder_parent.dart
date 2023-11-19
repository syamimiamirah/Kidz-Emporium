import 'package:flutter/material.dart';
import 'package:kidz_emporium/widget/calendar_widget.dart';

import '../../components/side_menu.dart';
import '../../contants.dart';

class ViewReminderParentPage extends StatefulWidget{
  const ViewReminderParentPage({Key? key}) : super(key: key);

  @override
  _viewReminderParentPageState createState() => _viewReminderParentPageState();
}
class _viewReminderParentPageState extends State<ViewReminderParentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("View Reminder"),
          centerTitle: true,
        ),
        body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.pushNamedAndRemoveUntil(context, '/create_reminder_parent', (route) => false, );
          },
        child: Icon(
            Icons.add,
            color: Colors.black),
        backgroundColor: kPrimaryColor,
      ),

    );
  }
}