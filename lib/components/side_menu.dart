import 'package:flutter/material.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/admin/create_therapist.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/Screens/home.dart';

import '../Screens/parent/view_reminder_parent.dart';

class NavBar extends StatelessWidget{
  const NavBar({key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Name"),
              accountEmail: Text('email@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network("https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png",
                width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("Home"),
            onTap: () => {
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePage()),
            ),
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
                  builder: (context) => CreateTherapist()),
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
                    builder: (context) => ViewReminderParentPage()),
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
