import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidz_emporium/Screens/parent/create_child_parent.dart';
import 'package:kidz_emporium/Screens/parent/update_child_parent.dart';
import 'package:kidz_emporium/Screens/parent/update_reminder_parent.dart';
import 'package:kidz_emporium/Screens/parent/view_reminder_parent.dart';
import 'package:kidz_emporium/components/side_menu.dart';
import 'package:kidz_emporium/models/child_model.dart';
import 'package:kidz_emporium/models/login_response_model.dart';
import 'package:kidz_emporium/contants.dart';

import '../../services/api_service.dart';

class ViewChildParentPage extends StatefulWidget {
  final LoginResponseModel userData;

  const ViewChildParentPage({Key? key, required this.userData}) : super(key: key);

  @override
  _ViewChildParentPageState createState() => _ViewChildParentPageState();
}

class _ViewChildParentPageState extends State<ViewChildParentPage> {
  List<ChildModel> children = []; // Added the list to store children

  @override
  void initState() {
    super.initState();
    _loadChildren(widget.userData.data!.id);
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

  String getImagePathByGender(String gender) {
    return gender == 'Male' ? 'assets/images/male_child.png' : 'assets/images/female_child.png';
  }

  void _deleteChild(String childId) {
    // Implement the deletion process here
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(userData: widget.userData),
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("View Child Profile"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your children",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(children[index].id ?? ''),
                    onDismissed: (direction) async {
                      String? childId = children[index].id;

                      // Ensure the reminderId is not null before attempting deletion
                      if (childId != null) {
                        bool deleteConfirmed = await showDeleteConfirmationDialog(context);

                        if (deleteConfirmed) {
                          bool deleteSuccess = await APIService.deleteChild(childId);

                          if (deleteSuccess) {
                            setState(() {
                              children!.removeAt(index);
                            });

                            // Show an AlertDialog for successful deletion
                            showAlertDialog(context, 'Child profile deleted successfully');
                          } else {
                            showAlertDialog(context, 'Failed to delete child profile');
                          }
                        }
                      }
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),

                    child: Card(
                      color: Colors.pink[100],
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        minVerticalPadding: 20,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(getImagePathByGender(children[index].gender ?? '')),
                        ),
                        title: Text(
                          children[index].childName ?? '',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Birth Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(children[index].birthDate as String))}",
                              style: TextStyle(color: Colors.black.withOpacity(0.7)),
                            ),
                            Text(
                              "Program: ${children[index].program ?? 'N/A'}",
                              style: TextStyle(color: Colors.black.withOpacity(0.7)),
                            ),
                            // Add any other details as needed
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateChildParentPage(userData: widget.userData, childId: children[index].id ?? ''),
                              ),
                            );
                          },
                        ),
                        // Add any other child details as needed
                      ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateChildParentPage(userData: widget.userData),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: kSecondaryColor,
      ),
    );
  }
}
