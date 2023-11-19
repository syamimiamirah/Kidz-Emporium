import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../components/side_menu.dart';
import '../../contants.dart';
import '../../utils.dart';
//import 'package:events_calendar_example/utils.dart';

class CreateReminderParentPage extends StatefulWidget{
  @override
  _createReminderParentPageState createState() => _createReminderParentPageState();

}
class _createReminderParentPageState extends State<CreateReminderParentPage>{
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? eventName;
  String? details;
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState(){
    super.initState();
    fromDate = DateTime.now();
    toDate = DateTime.now().add(Duration(hours: 2));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Create Reminder"),
        centerTitle: true,
      ),
      body: ProgressHUD(
        child: Form(
          child: _createReminderParentUI(context),
        )
      ),
      );
}
Widget _createReminderParentUI(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.only(top: 10),
                child: FormHelper.inputFieldWidget(context, "event", "Event Name", (onValidateVal){
                  if(onValidateVal.isEmpty){
                    return "Event name can't be empty";
                  }
                  return null;

                }, (onSavedVal){
                  eventName = onSavedVal.toString().trim();
                },
                  prefixIconColor: kPrimaryColor,
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.event_note),
                  borderRadius: 10,
                  borderColor: Colors.grey,
                  contentPadding: 15,
                  fontSize: 15,
                  prefixIconPaddingLeft: 10,
                ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child:
          FormHelper.inputFieldWidget(
            context,
            "details", "Details",
                (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Details can't be empty";
              }
              return null;
            },
                (onSavedVal){
              details = onSavedVal.toString().trim();
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

        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text('FROM', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ),

        Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey,),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ListTile(
                            title: Text(Utils.toDate(fromDate)),
                            trailing: Icon(Icons.arrow_drop_down),
                            onTap: () => pickFromDateTime(pickDate: true),
                          ),
                        ),
                          Expanded(
                            child: ListTile(
                              title: Text(Utils.toTime(fromDate)),
                              trailing: Icon(Icons.arrow_drop_down),
                              onTap: () => pickFromDateTime(pickDate: false),
                            ),
                        ),
                      ],
                    )
                  ],
                ),
          ),
        ),
        ),

        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text('TO', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey,),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(Utils.toDate(toDate)),
                          trailing: Icon(Icons.arrow_drop_down),
                          onTap: () => pickToDateTime(pickDate: true),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(Utils.toTime(toDate)),
                          trailing: Icon(Icons.arrow_drop_down),
                          onTap: ()=> pickToDateTime(pickDate: false),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
                  },
                    btnColor: Colors.grey,
                    txtColor: Colors.black,
                    borderRadius: 10,
                    borderColor: Colors.grey,
                  ),
                  SizedBox(width: 20),
                  FormHelper.submitButton("Save", (){
                  },
                    btnColor: Colors.orange,
                    txtColor: Colors.black,
                    borderRadius: 10,
                    borderColor: Colors.orange,),
                ],
              ),
            ],
          )
        ),

      ],

    ),

  );
  }
  Future pickFromDateTime({required bool pickDate}) async{
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if(date == null) return;

    if(date.isAfter(toDate)){
      toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(()
        => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async{
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if(date == null) return;

    setState(()
    => toDate = date);
  }

  Future<DateTime?> pickDateTime(
      DateTime initialDate,{
      required bool pickDate,
      DateTime? firstDate,
  }) async{
    if (pickDate){
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101),
      );

      if(date == null) return null;

      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    }else{
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if(timeOfDay == null) return null;
      final date = DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }
  bool validateAndSave(){
    final form = globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

}
