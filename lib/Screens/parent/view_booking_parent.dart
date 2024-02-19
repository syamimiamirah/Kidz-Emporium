import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidz_emporium/contants.dart';
import '../../models/booking_model.dart';
import '../../models/child_model.dart';
import '../../models/login_response_model.dart';
import '../../services/api_service.dart';
import '../../utils.dart';
import 'create_booking_parent.dart';

class ViewBookingParentPage extends StatefulWidget {
  final LoginResponseModel userData;

  const ViewBookingParentPage({Key? key, required this.userData}): super(key: key);
  @override
  _ViewBookingListPageState createState() => _ViewBookingListPageState();
}

class _ViewBookingListPageState extends State<ViewBookingParentPage> {
  List<BookingModel> booking = [];
  List<ChildModel> children = [];

  @override
  void initState() {
    super.initState();
    _loadData(widget.userData.data!.id);
  }

  Future<void> _loadData(String userId) async {
    try {
      // Use Future.wait to wait for both API calls to complete
      await Future.wait([
        _loadChildren(userId),
        _loadBooking(userId),
      ]);
    } catch (error) {
      print('Error loading data: $error');
    }
  }


  Future<void> _loadBooking(String userId) async{
    try{
      List<BookingModel> loadedBooking = await APIService.getBooking(widget.userData.data!.id);
      setState((){
        booking = loadedBooking;
    });
    }catch(error){
        print('Error loading bookings: $error');
    }
  }

  Future<void> _loadChildren(String userId) async {
    try {
      List<ChildModel> loadedChildren = await APIService.getChild(widget.userData.data!.id);

      setState(() {
        children = loadedChildren;
      });
    } catch (error) {
      print('Error loading children: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
        centerTitle: true,
        backgroundColor: kPrimaryColor, // Change the color to match your theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Bookings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: booking.length, // Replace with the actual number of bookings
                itemBuilder: (context, index) {
                  ChildModel? child = children.firstWhere(
                          (child) => child.id == booking[index].childId,
                      orElse: () => ChildModel(childName: 'Unknown', birthDate: '', gender: '', program: '', userId: ''),
                  );// Replace this with actual booking data from your API or local storage
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("Booking for ${child.childName}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      subtitle: Text(
                        "From: ${booking[index].fromDate}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),

                      onTap: () {
                        // Navigate to booking details page
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => CreateBookingParentPage(userData: widget.userData)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor, // Change the color to match your theme
      ),
    );
  }
}
