import 'package:flutter/material.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/Screens/parent/create_child_parent.dart';
import 'package:kidz_emporium/Screens/parent/view_booking_parent.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/Screens/home.dart';

import '../Screens/admin/create_therapist_admin.dart';
import '../Screens/admin/view_therapist_admin.dart';
import '../Screens/parent/create_booking_parent.dart';
import '../Screens/parent/view_child_parent.dart';
import '../Screens/parent/view_reminder_parent.dart';
import '../Screens/parent/view_therapist_parent.dart';
import '../Screens/therapist/view_child_therapist.dart';
import '../Screens/therapist/view_therapist.dart';
import '../models/child_model.dart';
import '../models/login_response_model.dart';
import '../models/therapist_model.dart';
import '../services/api_service.dart';

class NavBar extends StatefulWidget{
  final LoginResponseModel userData;

  const NavBar({Key? key, required this.userData}) : super(key: key);

  @override
  _navBarState createState() =>_navBarState();
}

class _navBarState extends State<NavBar>{

  List<TherapistModel> therapists = [];

  @override
  void initState() {
    super.initState();
    loadTherapists();// Load children data when the page initializes
  }

  Future<void> loadTherapists() async {
    try {
      List<TherapistModel> fetchedTherapists = await APIService.getAllTherapists();
      setState(() {
        therapists = fetchedTherapists;
      });
    } catch (error) {
      // Handle error
      print("Error fetching therapists: $error");
    }
  }
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
            leading: Icon(Icons.home),
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
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  ViewBookingParentPage(userData:widget.userData)),
            ),
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
                  builder: (context) => ViewTherapistParentPage(userData:widget.userData, therapists: therapists)),//CreateTherapist()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.child_care),
            title: Text("My Child"),
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  ViewChildParentPage(userData:widget.userData)),
            ),
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
            onTap: () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false,
            ),
          ),
        ],
      )
    );
  }
}

class AdminNavBar extends StatefulWidget{
  final LoginResponseModel userData;
  const AdminNavBar({Key? key, required this.userData}) : super(key: key);

  @override
  _adminNavBarState createState() =>_adminNavBarState();
}

class _adminNavBarState extends State<AdminNavBar> {
  @override
  Widget build(BuildContext context) {
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
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AdminHomePage(userData: widget.userData),
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
                    builder: (context) =>
                        ViewTherapistAdminPage(
                            userData: widget.userData)), //CreateTherapist()),
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
              onTap: () => null,
                  /*Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          ViewReminderParentPage(userData: widget.userData)),
                  ),*/
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false,
              ),
            ),
          ],
        )
    );
  }
}

class TherapistNavBar extends StatefulWidget{
  final LoginResponseModel userData;
  const TherapistNavBar({Key? key, required this.userData}) : super(key: key);

  @override
  _therapistNavBarState createState() =>_therapistNavBarState();
}

class _therapistNavBarState extends State<TherapistNavBar> {

  List<ChildModel> children = [];
  List<TherapistModel> therapists = [];

  @override
  void initState() {
    super.initState();
    loadChildren();
    loadTherapists();// Load children data when the page initializes
  }

  // Function to fetch children data
  Future<void> loadChildren() async {
    try {
      List<ChildModel> fetchedChildren = await APIService.getAllChildren();
      setState(() {
        children = fetchedChildren;
      });
    } catch (error) {
      // Handle error
      print("Error fetching children: $error");
    }
  }

  Future<void> loadTherapists() async {
    try {
      List<TherapistModel> fetchedTherapists = await APIService.getAllTherapists();
      setState(() {
        therapists = fetchedTherapists;
      });
    } catch (error) {
      // Handle error
      print("Error fetching therapists: $error");
    }
  }
  @override
  Widget build(BuildContext context) {
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
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TherapistHomePage(userData: widget.userData),
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
                    builder: (context) =>
                        TherapistDetailPage(
                            userData: widget.userData, therapists: therapists)), //CreateTherapist()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.child_care),
              title: Text("My Child"),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          ViewChildTherapistPage(userData: widget.userData, children: children)),
                  ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text("Calendar"),
              onTap: () => null,
                  /*Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          ViewReminderParentPage(userData: widget.userData)),
                  ),*/
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false,
              ),
            ),
          ],
        )
    );
  }
}
