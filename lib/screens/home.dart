import 'package:flutter/material.dart';
import 'package:kidz_emporium/Screens/admin/view_therapist_admin.dart';
import 'package:kidz_emporium/Screens/admin/view_youtube_admin.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/Screens/parent/create_booking_parent.dart';
import 'package:kidz_emporium/Screens/parent/create_child_parent.dart';
import 'package:kidz_emporium/Screens/parent/view_booking_parent.dart';
import 'package:kidz_emporium/Screens/parent/view_child_parent.dart';
import 'package:kidz_emporium/Screens/parent/view_reminder_parent.dart';
import 'package:kidz_emporium/Screens/parent/view_report_parent.dart';
import 'package:kidz_emporium/Screens/parent/view_therapist_parent.dart';
import 'package:kidz_emporium/Screens/therapist/create_video_therapist.dart';
import 'package:kidz_emporium/Screens/therapist/view_booking_therapist.dart';
import 'package:kidz_emporium/Screens/therapist/view_child_therapist.dart';
import 'package:kidz_emporium/Screens/therapist/view_report_therapist.dart';
import 'package:kidz_emporium/Screens/therapist/view_task_therapist.dart';
import 'package:kidz_emporium/Screens/therapist/view_therapist.dart';
import 'package:kidz_emporium/Screens/therapist/view_video_therapist.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:kidz_emporium/components/side_menu.dart';
import 'package:kidz_emporium/models/login_response_model.dart';
import 'package:kidz_emporium/models/user_model.dart';
import '../config.dart';
import '../main.dart';
import '../models/booking_model.dart';
import '../models/child_model.dart';
import '../models/therapist_model.dart';
import '../services/api_service.dart';
import '../services/shared_service.dart';
import 'admin/create_task_admin.dart';
import 'admin/create_therapist_admin.dart';
import 'admin/view_booking_admin.dart';
import 'admin/view_task_admin.dart';

class HomePage extends StatefulWidget {
  final LoginResponseModel userData;
  const HomePage({Key? key, required this.userData}) : super(key: key);

  @override
  _homePageState createState() =>_homePageState();
}

class _homePageState extends State<HomePage>{
  List<BookingModel> bookings = [];
  //Creating static data in lists
  List catNames = [
    "Booking",
    "Therapist",
    "Report",
    "Video",
    "Calendar",
    "Child"
  ];

  List<Color> catColors= [
    kPrimaryColor,
    kSecondaryColor,
    kPrimaryColor,
    kSecondaryColor,
    kPrimaryColor,
    kSecondaryColor,
  ];

  List<Icon> catIcons = [
    Icon(Icons.library_books, color: Colors.white, size: 30),
    Icon(Icons.people, color: Colors.white, size: 30),
    Icon(Icons.event_note, color: Colors.white, size: 30),
    Icon(Icons.video_library, color: Colors.white, size: 30),
    Icon(Icons.calendar_month, color: Colors.white, size: 30),
    Icon(Icons.child_care, color: Colors.white, size: 30),
  ];
  List bookingList = [
    'Booking 1', 'Booking 2', 'Booking 3', 'Booking 4'
  ];

  @override
  void initState() {
    super.initState();
  }

  Future <void> _loadBooking() async {
    try {
      List<BookingModel> loadedBooking = await APIService.getBooking(widget.userData.data!.id);
      setState(() {
        bookings = loadedBooking;
      });
    } catch (error) {
      print('Error loading bookings: $error');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavBar(userData: widget.userData),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Parent Home Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false,
            )
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Text("Hi, ${widget.userData.data?.name ?? 'User'}!", style: TextStyle(fontSize: 25,color: Colors.white, decoration: TextDecoration.none)),
                    ],
                  ),
                )
              ],
            )
          ),
          Padding(padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              GridView.builder(
                itemCount: catNames.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index){
                  return InkWell( // Wrap the container with InkWell for clickability
                      onTap: () async {
                    // Handle the click event for the calendar
                   List<TherapistModel> therapists = await APIService.getAllTherapists();
                   List<UserModel> users = await APIService.getAllUsers();
                    if (catNames[index] == "Booking") {
                      // Add your code here to navigate or perform an action
                      // when the calendar is clicked
                      print("Booking clicked!");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  ViewBookingParentPage(userData:widget.userData)),
                      );
                    }

                    if (catNames[index] == "Therapist") {
                      // Add your code here to navigate or perform an action
                      // when the calendar is clicked
                      print("Therapist clicked!");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewTherapistParentPage(userData:widget.userData, therapists: therapists, users: users,)),//CreateTherapist()),
                      );
                    }
                    if (catNames[index] == "Report") {
                      // Add your code here to navigate or perform an action
                      // when the calendar is clicked
                      print("Report clicked!");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  ViewReportParentPage(userData:widget.userData)),
                      );
                    }
                    if (catNames[index] == "Video") {
                      // Add your code here to navigate or perform an action
                      // when the calendar is clicked
                      print("Video clicked!");
                      /*Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  ViewYoutubeAdmin(userData:widget.userData)),
                      );*/
                    }
                    if (catNames[index] == "Calendar") {
                      // Add your code here to navigate or perform an action
                      // when the calendar is clicked
                      print("Calendar clicked!");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  ViewReminderParentPage(userData:widget.userData)),
                      );
                    }
                    if (catNames[index] == "Child") {
                      // Add your code here to navigate or perform an action
                      // when the calendar is clicked
                      print("Child clicked!");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewChildParentPage(userData:widget.userData)),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: catColors[index],
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: catIcons[index],),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        catNames[index], style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.6),
                      ),
                      ),
                    ],
                  ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Booking",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewBookingParentPage(userData:widget.userData)),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 18,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                itemCount: bookingList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index){
                  return InkWell(
                    onTap:(){},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kSecondaryColor.withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10),
                            child: Icon(Icons.person, size: 50),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            bookingList[index],
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "On 22 Oct 2023",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          )
        ],
      ),
    );
  }
}

//Admin Home Page
class AdminHomePage extends StatefulWidget {
  final LoginResponseModel userData;
  const AdminHomePage({Key? key, required this.userData}) : super(key: key);

  @override
  _adminHomePageState createState() =>_adminHomePageState();
}

class _adminHomePageState extends State<AdminHomePage>{
  List<BookingModel> bookings = [];
  //Creating static data in lists
  List catNames = [
    "Booking",
    "Therapist",
    "Report",
    "Video",
    "Task",
    "Child"
  ];

  List<Color> catColors= [
    kPrimaryColor,
    kSecondaryColor,
    kPrimaryColor,
    kSecondaryColor,
    kPrimaryColor,
    kSecondaryColor,
  ];

  List<Icon> catIcons = [
    Icon(Icons.library_books, color: Colors.white, size: 30),
    Icon(Icons.people, color: Colors.white, size: 30),
    Icon(Icons.event_note, color: Colors.white, size: 30),
    Icon(Icons.video_library, color: Colors.white, size: 30),
    Icon(Icons.calendar_month, color: Colors.white, size: 30),
    Icon(Icons.child_care, color: Colors.white, size: 30),
  ];
  List bookingList = [
    'Booking 1', 'Booking 2', 'Booking 3', 'Booking 4'
  ];

  @override
  void initState() {
    super.initState();
  }

  Future <void> _loadBooking() async {
    try {
      List<BookingModel> loadedBookings = await APIService.getAllBookings();
      setState(() {
        bookings = loadedBookings;
      });
    } catch (error) {
      print('Error loading bookings: $error');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: AdminNavBar(userData: widget.userData),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Admin Home Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false,
              )
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Text("Hi, ${widget.userData.data?.name ?? 'User'}!", style: TextStyle(fontSize: 25,color: Colors.white, decoration: TextDecoration.none)),
                      ],
                    ),
                  )
                ],
              )
          ),
          Padding(padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: catNames.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index){
                    return InkWell( // Wrap the container with InkWell for clickability
                      onTap: () {
                        // Handle the click event for the calendar
                        if (catNames[index] == "Booking") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Booking clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ViewBookingAdminPage(userData:widget.userData)),
                          );
                        }
                        if (catNames[index] == "Therapist") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Therapist clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ViewTherapistAdminPage(userData:widget.userData)),//CreateTherapist()),
                          );
                        }
                        if (catNames[index] == "Report") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Report clicked!");
                          /*Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ViewReminderParentPage(userData:widget.userData)),
                          );*/
                        }
                        if (catNames[index] == "Video") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Video clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ViewYoutubeAdmin(userData:widget.userData)),
                          );
                        }
                        if (catNames[index] == "Task") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Task clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ViewTaskAdminPage(userData:widget.userData)),
                          );
                        }
                        if (catNames[index] == "Child") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Child clicked!");
                          /*Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ViewChildParentPage(userData:widget.userData)),
                          );*/
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: catColors[index],
                              shape: BoxShape.rectangle,
                            ),
                            child: Center(
                              child: catIcons[index],),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            catNames[index], style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.6),
                          ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Booking",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewBookingAdminPage(userData:widget.userData)),
                        );
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 18,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  itemCount: bookingList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap:(){},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kSecondaryColor.withOpacity(0.2),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.all(10),
                              child: Icon(Icons.person, size: 50),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              bookingList[index],
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "On 22 Oct 2023",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//Therapist HomePage
class TherapistHomePage extends StatefulWidget {
  final LoginResponseModel userData;
  const TherapistHomePage({Key? key, required this.userData}) : super(key: key);

  @override
  _therapistHomePageState createState() =>_therapistHomePageState();
}

class _therapistHomePageState extends State<TherapistHomePage>{
  List<BookingModel> bookings = [];
  //Creating static data in lists
  List catNames = [
    "Booking",
    "Therapist",
    "Report",
    "Video",
    "Task",
    "Child"
  ];

  List<Color> catColors= [
    kPrimaryColor,
    kSecondaryColor,
    kPrimaryColor,
    kSecondaryColor,
    kPrimaryColor,
    kSecondaryColor,
  ];

  List<Icon> catIcons = [
    Icon(Icons.library_books, color: Colors.white, size: 30),
    Icon(Icons.people, color: Colors.white, size: 30),
    Icon(Icons.event_note, color: Colors.white, size: 30),
    Icon(Icons.video_library, color: Colors.white, size: 30),
    Icon(Icons.calendar_month, color: Colors.white, size: 30),
    Icon(Icons.child_care, color: Colors.white, size: 30),
  ];
  List bookingList = [
    'Booking 1', 'Booking 2', 'Booking 3', 'Booking 4'
  ];

  @override
  void initState() {
    super.initState();
  }

  Future <void> _loadBooking() async {
    try {
      List<BookingModel> loadedBookings = await APIService.getAllBookings();
      List<BookingModel> therapistBookings = loadedBookings.where((booking) => booking.therapistId == widget.userData.data?.id).toList();
      setState(() {
        bookings = therapistBookings;
      });
    } catch (error) {
      print('Error loading bookings: $error');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: TherapistNavBar(userData: widget.userData),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Therapist Home Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false,
              )
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Text("Hi, ${widget.userData.data?.name ?? 'User'}!", style: TextStyle(fontSize: 25,color: Colors.white, decoration: TextDecoration.none)),
                      ],
                    ),
                  )
                ],
              )
          ),
          Padding(padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: catNames.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index){
                    return InkWell( // Wrap the container with InkWell for clickability
                      onTap: () async {
                        // Handle the click event for the calendar
                        if (catNames[index] == "Booking") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Booking clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ViewBookingTherapistPage(userData:widget.userData)),
                          );
                        }
                        List<TherapistModel> therapists = await APIService.getAllTherapists();
                        List<UserModel> users = await APIService.getAllUsers();
                        if (catNames[index] == "Therapist") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Therapist clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => TherapistDetailPage(userData:widget.userData, therapists: therapists, users: users)),//CreateTherapist()),
                          );
                        }
                        if (catNames[index] == "Report") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Report clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ViewReportTherapistPage(userData:widget.userData)),
                          );
                        }
                        if (catNames[index] == "Video") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Video clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ViewVideoTherapistPage(userData:widget.userData)),
                          );
                        }
                        if (catNames[index] == "Task") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Task clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ViewTaskTherapistPage(userData:widget.userData)),
                          );
                        }

                        List<ChildModel> children = await APIService.getAllChildren();
                        if (catNames[index] == "Child") {
                          // Add your code here to navigate or perform an action
                          // when the calendar is clicked
                          print("Child clicked!");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ViewChildTherapistPage(userData:widget.userData, children: children)),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: catColors[index],
                              shape: BoxShape.rectangle,
                            ),
                            child: Center(
                              child: catIcons[index],),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            catNames[index], style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.6),
                          ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Booking",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewBookingTherapistPage(userData:widget.userData)),
                        );
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 18,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  itemCount: bookingList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap:(){},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kSecondaryColor.withOpacity(0.2),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.all(10),
                              child: Icon(Icons.person, size: 50),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              bookingList[index],
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "On 22 Oct 2023",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
