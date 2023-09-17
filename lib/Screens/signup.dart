import 'package:flutter/material.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/signin.dart';

class SignUpScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage("assets/images/logo-centre.png"),
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Create a New Account",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child:Row(
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
                        Padding(
                          padding: EdgeInsets.only(bottom: 13),
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
                                      hintText: "Enter Your Email Address"
                                  )
                              )
                          ),
                          ],
                        ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.phone,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Expanded(
                                  child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Enter Your Phone Number"
                                      )
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.admin_panel_settings,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Expanded(
                                  child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Enter Your Role"
                                      )
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 13),
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
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Enter Your Password",
                                              suffixIcon: Icon(Icons.visibility, color: kPrimaryColor)
                                      ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: GestureDetector(
                            onTap:() {Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreen();
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
                                    Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                                  ]
                              ),
                            ),
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already Have an Account?", style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return SignInScreen();
                                },
                              ));
                              },
                              child: Text(
                                " Sign In",
                                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]
                        ),
                      ]

                    )

      ),


            ),


      ]
      ),
    );
  }
}