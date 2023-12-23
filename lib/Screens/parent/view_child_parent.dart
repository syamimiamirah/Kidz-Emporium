import 'package:flutter/material.dart';
import 'package:kidz_emporium/Screens/parent/create_child_parent.dart';
import 'package:kidz_emporium/components/side_menu.dart';
import 'package:kidz_emporium/models/login_response_model.dart';
import 'package:kidz_emporium/contants.dart';


class ViewChildParentPage extends StatefulWidget{
  final LoginResponseModel userData;

  const ViewChildParentPage({Key? key,  required this.userData}): super(key: key);

  @override
  _viewChildParentPageState createState() => _viewChildParentPageState();
}

class _viewChildParentPageState extends State<ViewChildParentPage>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavBar(userData: widget.userData),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("View Child Profile"),
        centerTitle: true,
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
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
