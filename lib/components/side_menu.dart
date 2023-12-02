import 'package:flutter/material.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/admin/create_therapist.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/Screens/home.dart';

import '../Screens/parent/view_reminder_parent.dart';
import '../models/login_response_model.dart';

class NavBar extends StatefulWidget{
  final LoginResponseModel userData;
  const NavBar({Key? key, required this.userData}) : super(key: key);

  @override
  _navBarState createState() =>_navBarState();
}

class _navBarState extends State<NavBar>{
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("${widget.userData.data?.name ?? 'User'}"),
              accountEmail: Text("${widget.userData.data?.email ?? 'User'}"),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("Home"),
            onTap: () {
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomePage(userData: widget.userData),
                ));
                },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("Booking"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Payment"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.event_note),
            title: Text("Report"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text("Video"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Therapist"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CreateTherapistPage(userData:widget.userData)),//CreateTherapist()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.child_care),
            title: Text("My Child"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text("Calendar"),
            onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  ViewReminderParentPage(userData:widget.userData)),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () => null,
          ),
        ],
      )
    );
  }
}
