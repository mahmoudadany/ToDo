import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Tasks/shard/component/component.dart';

class BottomSheetScreen extends StatefulWidget {
  TextEditingController titlecontroller;
  TextEditingController timecontroller;
  TextEditingController datecontroller;
  GlobalKey<FormState> formKey;

  BottomSheetScreen({
    required this.formKey,
    required this.titlecontroller,
    required this.timecontroller,
    required this.datecontroller

  }){}

  @override
  State<BottomSheetScreen> createState() {
    return _BottomSheetScreenState(formKey: formKey, timecontroller: timecontroller, titlecontroller: titlecontroller, datecontroller: datecontroller);
  }
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
   TextEditingController titlecontroller;
   TextEditingController timecontroller;
   TextEditingController datecontroller;
   GlobalKey<FormState> formKey;



   _BottomSheetScreenState({
     required this.formKey,
     required this.titlecontroller,
     required this.timecontroller,
     required this.datecontroller
}){

   }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultTextFormField(
                controller: titlecontroller,
                text: "Task Title",
                icon: Icons.title,
              validator: (text){
                text!.isEmpty? "you shoud enter any text": null;
              },
            ),
           const SizedBox(height: 10.0,),
            defaultTextFormField(
                controller: timecontroller,
                text: "Task Time",
                icon: Icons.watch_later_outlined,
                validator: (text){
                text!.isEmpty? "you shoud enter any time": null;
              },
                onTap: (){
                  showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()
                  ).then((value) {

                    timecontroller.text=value!.format(context);
                  } );
                }
            ),
           const SizedBox(height: 10.0,),
            defaultTextFormField(
                controller: datecontroller,
                icon: Icons.calendar_month,
                text: "Task Date",
              validator: (text){
                text!.isEmpty? "you shoud enter any date": null;
              },
                onTap: (){
                 showDatePicker(
                     context: context,
                     initialDate: DateTime.now(),
                     firstDate: DateTime.now(),
                     lastDate: DateTime.parse('2030-12-30'))
                 .then((value) {
                   datecontroller.text=DateFormat.yMMMd().format(value!);
                 });
                }
            ),
          ],
        ),
      ),
    );
  }
}
