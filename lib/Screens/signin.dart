import 'package:flutter/material.dart';
import 'package:kidz_emporium/Screens/home.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/signup.dart';

class SignInScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:AssetImage("assets/images/logo-centre.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter,
                  ),
              ),
            ),
          ),
          Text(
            "Welcome Back!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.email,
                            color: kSecondaryColor,
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
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.lock,
                              color: kSecondaryColor,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Enter Your Password",
                                  suffixIcon: Icon(Icons.visibility, color: kSecondaryColor)
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
                              return HomePage();
                            },
                          ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.pink,
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                                ]
                            ),
                          ),
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't Have an Account?", style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return SignUpScreen();
                              },
                            ));
                            },
                            child: Text(
                              " Sign Up",
                              style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                    ),
                      ],
                    ),
                ),
            ),
        ]
      ),
    );
  }
}