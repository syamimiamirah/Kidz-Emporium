import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:kidz_emporium/components/side_menu.dart';
import 'package:kidz_emporium/contants.dart';
import 'package:kidz_emporium/Screens/login_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../models/login_response_model.dart';
import '../parent/view_reminder_parent.dart';



class CreateTherapistPage extends StatefulWidget{
  final LoginResponseModel userData;
  const CreateTherapistPage({Key? key, required this.userData}) : super(key: key);

  @override
  _createTherapistPageState createState() =>_createTherapistPageState();
}

class _createTherapistPageState extends State<CreateTherapistPage>{
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isAPICallProcess =  false;
  String? therapistName;
  String? specialization;
  DateTime? hiringDate;
  String? aboutMe;
  bool isHiringDateSet = false;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Create Therapist Profile"),
        centerTitle: true,
      ),
      body: ProgressHUD(
          child: Form(
            key: _createTherapistPageState.globalFormKey,
            child: _createTherapistAdminUI(context),
          )
      ),
    );
  }

  Widget _createTherapistAdminUI(BuildContext context){
    return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FormHelper.inputFieldWidget(context, "therapist", "Therapist Name", (onValidateVal){
                if(onValidateVal.isEmpty){
                  return "Therapist name can't be empty";
                }
                return null;

              }, (onSavedVal){
                therapistName = onSavedVal.toString().trim();
              },
                prefixIconColor: kPrimaryColor,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.person),
                borderRadius: 10,
                borderColor: Colors.grey,
                contentPadding: 15,
                fontSize: 15,
                prefixIconPaddingLeft: 10,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey,),

                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.school, // Your desired icon
                          color: kPrimaryColor, // Icon color
                        ),
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: specialization,
                            hint: const Text("Specialization"),
                            items: [
                              DropdownMenuItem<String>(
                                value: null,
                                child: Text("Specialization",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              ),
                              // Other role options
                              DropdownMenuItem<String>(
                                value: "Occupational Therapy",
                                child: Text("Occupational Therapy",style: TextStyle(fontSize: 15,),),
                              ),
                              DropdownMenuItem<String>(
                                value: "Speech-Language Pathology",
                                child: Text("Speech-Language Pathology",style: TextStyle(fontSize: 15,),),
                              ),
                              DropdownMenuItem<String>(
                                value: "Psychology, Counselling",
                                child: Text("Psychology, Counselling",style: TextStyle(fontSize: 15,),),
                              ),
                              DropdownMenuItem<String>(
                                value: "Special Education",
                                child: Text("Special Education",style: TextStyle(fontSize: 15,),),
                              ),
                              DropdownMenuItem<String>(
                                value: "Early Childhood Education",
                                child: Text("Early Childhood Education",style: TextStyle(fontSize: 15,),),
                              ),
                            ],// The first item is the hint, set its value to null
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                            onChanged: (String? newValue){
                              //Your code to execute, when a menu item is selected from dropdown
                              //dropDownStringItem = value;
                              setState(() {
                                this.specialization = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey,),
                    ),
                    child: Row(
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.calendar_today, // Your desired icon for date picker
                              color: kPrimaryColor, // Icon color
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                ).then((selectedDate){
                                  if(selectedDate != null && selectedDate != hiringDate){
                                    setState(() {
                                      hiringDate = selectedDate;
                                      isHiringDateSet = true;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  hiringDate != null
                                      ? "${hiringDate!.toLocal()}".split(' ')[0]
                                      : 'Hiring Date',
                                  style: TextStyle(fontSize: 15, fontWeight: isHiringDateSet ? FontWeight.normal : FontWeight.bold,),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                )
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
              FormHelper.inputFieldWidget(
                context,
                "about me", "About Me",
                    (onValidateVal){
                  if(onValidateVal.isEmpty){
                    return "About Me can't be empty";
                  }
                  return null;
                },
                    (onSavedVal){
                  aboutMe = onSavedVal.toString().trim();
                },
                prefixIconColor: kPrimaryColor,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.description),
                borderRadius: 10,
                borderColor: Colors.grey,
                contentPadding: 15,
                fontSize: 15,
                prefixIconPaddingLeft: 10,
                prefixIconPaddingBottom: 55,
                isMultiline: true,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormHelper.submitButton("Cancel", (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) =>  ViewReminderParentPage(userData:widget.userData)),
                        );
                      },
                        btnColor: Colors.grey,
                        txtColor: Colors.black,
                        borderRadius: 10,
                        borderColor: Colors.grey,
                      ),
                      SizedBox(width: 20),
                      FormHelper.submitButton(
                        "Save", (){
                        if(validateAndSave()){
                          setState(() {
                            isAPICallProcess = true;
                          });
                          /*if(response != null){
                            FormHelper.showSimpleAlertDialog(context, Config.appName, "Child Profile created", "OK", () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewReminderParentPage(userData: widget.userData),
                                ),
                              );
                            },
                            );
                          }*/

                        }
                      },
                        btnColor: Colors.orange,
                        txtColor: Colors.black,
                        borderRadius: 10,
                        borderColor: Colors.orange,
                      ),
                    ],
                  )
                ],
              )
            )
          ],
        )
    );
  }
  bool validateAndSave() {
    print("Validate and Save method is called");
    final form = globalFormKey.currentState;
    if (form != null && form.validate()) {
      print("Save method is called");
      form.save();
      return true;
    } else {
      return false;
    }
  }

}
