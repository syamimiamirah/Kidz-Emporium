import 'package:flutter/material.dart';
import 'package:kidz_emporium/components/side_menu.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/signin.dart';


class CreateTherapist extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => SignInScreen(),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Create Therapist Profile", style: TextStyle(fontSize: 25,color: Colors.white, decoration: TextDecoration.none, )),
                ],
              ),
            )
          ],
        ),
    ),
          Padding(padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                Icons.person,
                color: kPrimaryColor,
                ),
              ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Your Full Name",
                      ),
                    ),
                  ),
                ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.calendar_month,
                    color: kPrimaryColor,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your Hiring Date",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.email,
                    color: kPrimaryColor,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your Email Address",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20,),
            child: FittedBox(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CreateTherapist();
                    },
                  ));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Create An Account", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                      ]
                  ),
                ),
              ),
              ),
            ),
        ],
      )
    );
  }
}
